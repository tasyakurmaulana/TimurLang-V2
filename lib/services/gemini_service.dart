// ============================================================================
// 🤖 [KODINGAN ARTIFICIAL INTELLIGENCE (AI) - GEMINI & GROQ LLM SERVICE]
// ----------------------------------------------------------------------------
// File: gemini_service.dart
// Penjelasan:
// - Mengintegrasikan model AI cerdas (Google Gemini AI & Groq LLaMA)
// - Berfungsi sebagai asisten virtual pintar pendaki gunung (Survival Assistant)
// - Memberikan respon otomatis terkait: P3K darurat hipotermia, navigasi alam liar,
//   manajemen logistik, analisis prakiraan cuaca, serta etika pendakian
// - Menyediakan fallback cerdas secara lokal jika perangkat sedang offline di gunung
// ============================================================================

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isFromCloud;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isFromCloud = false,
  });
}

class GeminiService {
  static final GeminiService instance = GeminiService._internal();
  GeminiService._internal();

  final List<ChatMessage> _history = [];
  List<ChatMessage> get history => List.unmodifiable(_history);

  String? _customApiKey;

  String get currentApiKey {
    if (_customApiKey != null && _customApiKey!.trim().isNotEmpty) {
      final k = _customApiKey!.trim();
      if (k.startsWith('gsk_') || k.startsWith('AIzaSy')) {
        return k;
      }
    }
    const envKey = String.fromEnvironment('AI_API_KEY', defaultValue: '');
    if (envKey.isNotEmpty) return envKey;
    if (AppConstants.aiApiKey.trim().isNotEmpty && !AppConstants.aiApiKey.startsWith('AQ.')) {
      return AppConstants.aiApiKey.trim();
    }
    return '';
  }

  bool get isGroq => currentApiKey.startsWith('gsk_');
  bool get isGemini => currentApiKey.startsWith('AIzaSy');
  bool get hasValidApiKey => currentApiKey.isNotEmpty;
  String get activeProviderName => isGroq ? 'Groq Cloud AI' : (isGemini ? 'Gemini Cloud AI' : 'Cloud AI');

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _customApiKey = prefs.getString('custom_gemini_api_key');
      // Bersihkan key lama yang rusak/invalid dari SharedPreferences
      if (_customApiKey != null &&
          !_customApiKey!.startsWith('gsk_') &&
          !_customApiKey!.startsWith('AIzaSy')) {
        debugPrint('[GeminiService] Menghapus stored key invalid: $_customApiKey');
        _customApiKey = null;
        await prefs.remove('custom_gemini_api_key');
      }
      debugPrint('[GeminiService] Init selesai. hasValidApiKey=$hasValidApiKey, provider=$activeProviderName, keyPrefix=${currentApiKey.isNotEmpty ? currentApiKey.substring(0, 8) : "KOSONG"}');
    } catch (e) {
      debugPrint('[GeminiService] Error loading custom API key: $e');
    }
  }

  Future<void> setCustomApiKey(String key) async {
    _customApiKey = key.trim().replaceAll("'", "").replaceAll('"', '').replaceAll('`', '').replaceAll(' ', '');
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_customApiKey!.isEmpty) {
        await prefs.remove('custom_gemini_api_key');
      } else {
        await prefs.setString('custom_gemini_api_key', _customApiKey!);
      }
    } catch (e) {
      debugPrint('[GeminiService] Error saving custom API key: $e');
    }
  }

  /// Tes koneksi API Key secara live ke Groq atau Gemini
  Future<bool> testApiKey(String key) async {
    final cleanKey = key.trim().replaceAll("'", "").replaceAll('"', '').replaceAll('`', '').replaceAll(' ', '');
    if (cleanKey.isEmpty) return false;

    // Tes Groq API jika key berawalan gsk_
    if (cleanKey.startsWith('gsk_')) {
      try {
        final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');
        final res = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $cleanKey',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'model': 'qwen/qwen3.8-27b',
            'messages': [
              {'role': 'user', 'content': 'ping'}
            ],
            'max_tokens': 5,
          }),
        ).timeout(const Duration(seconds: 10));
        return res.statusCode == 200;
      } catch (_) {
        return false;
      }
    }

    // Default: Tes Google Gemini API
    try {
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$cleanKey',
      );
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': 'ping'}
              ]
            }
          ]
        }),
      ).timeout(const Duration(seconds: 10));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Tambah pesan sambutan awal berfokus khusus pada pendakian
  void addGreeting() {
    if (_history.isEmpty) {
      _history.add(
        ChatMessage(
          text: 'Halo! Saya Tbot, asisten AI resmi pendakian dari TimurLang.\n\n'
              'Saya siap membantu Anda seputar persiapan, informasi jalur, dan keselamatan pendakian:\n'
              '• Rekomendasi gunung & informasi jalur pendakian\n'
              '• Tips perlengkapan, checklist packing, & logistik\n'
              '• Prakiraan cuaca gunung & pemahaman fenomena alam\n'
              '• Pertolongan Pertama (P3K) & penanganan darurat (Hipotermia/AMS)\n'
              '• Panduan fitur aplikasi TimurLang & perizinan Simaksi\n\n'
              'Ada yang ingin Anda tanyakan seputar rencana pendakian Anda?',
          isUser: false,
          timestamp: DateTime.now(),
          isFromCloud: true,
        ),
      );
    }
  }

  // ==========================================================================
  // 🧠 [KODINGAN UTAMA AI: PENGIRIMAN PROMPT KE CLOUD LLM / OFFLINE FALLBACK]
  // ==========================================================================
  /// Send message to Universal Assistant
  Future<String> sendMessage(String message) async {
    // Add user message
    _history.add(ChatMessage(text: message, isUser: true, timestamp: DateTime.now()));

    String response;
    bool isCloud = false;

    // Hubungi Cloud AI (Groq API atau Google Gemini API)
    if (!hasValidApiKey) {
      debugPrint('[GeminiService] Tidak ada API key valid → langsung offline');
      response = _generateUniversalResponse(message);
      isCloud = false;
    } else {
      try {
        debugPrint('[GeminiService] Memanggil $activeProviderName (key=${currentApiKey.substring(0, 8)}...)');
        if (isGroq) {
          response = await _callGroqApi(message);
        } else {
          response = await _callGeminiApi(message);
        }
        isCloud = true;
        debugPrint('[GeminiService] ✅ Cloud AI berhasil menjawab');
      } catch (e) {
        debugPrint('[GeminiService] ❌ Cloud API ($activeProviderName) gagal: $e');
        response = _generateUniversalResponse(message);
        isCloud = false;
      }
    }

    _history.add(ChatMessage(
      text: response,
      isUser: false,
      timestamp: DateTime.now(),
      isFromCloud: isCloud,
    ));
    return response;
  }

  /// Call Groq OpenAI-compatible Chat Completions API
  Future<String> _callGroqApi(String message) async {
    final key = currentApiKey;
    if (key.isEmpty) {
      throw Exception('Groq API Key belum disetel.');
    }

    // Model aktif terbaru di Groq (Nov 2026)
    const candidateModels = [
      'qwen/qwen3.8-27b',
      'openai/gpt-oss-120b',
      'openai/gpt-oss-20b',
    ];

    // Bangun daftar percakapan standar OpenAI
    final List<Map<String, String>> messages = [
      {
        'role': 'system',
        'content': 'Kamu adalah Tbot, asisten AI resmi TimurLang. Kamu adalah pakar pendakian gunung, keselamatan di alam bebas, perlengkapan outdoor, navigasi alam, dan sistem perizinan Simaksi di Indonesia.\n\n'
            'PANDUAN PERILAKU:\n'
            '1. Jawab setiap pertanyaan seputar gunung, alam bebas, cuaca, perlengkapan, dan pendakian secara mendalam, cerdas, akurat, dan mengalir natural (BUKAN jawaban template).\n'
            '2. Gunakan gaya bahasa yang ramah, santun, hangat, dan terstruktur rapi (gunakan poin-poin tebal markdown jika menjelaskan banyak hal).\n'
            '3. Selalu utamakan keselamatan (safety first) dan prinsip kelestarian alam (Leave No Trace).\n'
            '4. Jika pengguna bertanya hal di luar alam bebas atau pendakian, tolak dengan santun dan ramah lalu ajak berdiskusi seputar rencana mendaki.',
      }
    ];

    // Ambil maksimal 8 riwayat percakapan sebelumnya
    final previousHistory = _history.length > 1
        ? (_history.length > 8 ? _history.sublist(_history.length - 8, _history.length - 1) : _history.sublist(0, _history.length - 1))
        : <ChatMessage>[];

    for (final item in previousHistory) {
      final text = item.text.trim();
      if (text.isEmpty) continue;
      messages.add({
        'role': item.isUser ? 'user' : 'assistant',
        'content': text,
      });
    }

    // Tambah pesan pengguna terbaru
    messages.add({
      'role': 'user',
      'content': message.trim(),
    });

    final headers = {
      'Authorization': 'Bearer $key',
      'Content-Type': 'application/json',
    };

    Exception? lastError;
    for (final model in candidateModels) {
      try {
        final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');
        final res = await http.post(
          url,
          headers: headers,
          body: json.encode({
            'model': model,
            'messages': messages,
            'temperature': 0.7,
            'max_tokens': 2048,
          }),
        ).timeout(const Duration(seconds: 25));

        if (res.statusCode == 200) {
          final jsonRes = json.decode(utf8.decode(res.bodyBytes));
          final content = jsonRes['choices']?[0]?['message']?['content'];
          if (content != null && content.toString().trim().isNotEmpty) {
            return content.toString().trim();
          }
        }
        lastError = Exception('Groq API ($model) status ${res.statusCode}: ${res.body}');
      } catch (e) {
        lastError = Exception('Groq API ($model) error: $e');
      }
    }

    throw lastError ?? Exception('Gagal memanggil Groq Cloud API.');
  }

  /// Call Gemini Flash API with context & alternating turn validation
  Future<String> _callGeminiApi(String message) async {
    final key = currentApiKey;
    if (key.isEmpty) {
      throw Exception('API Key Gemini belum disetel.');
    }

    // Daftar model aktif resmi Google AI Studio
    const candidateModels = [
      'gemini-2.0-flash',
      'gemini-1.5-flash',
      'gemini-1.5-pro',
      'gemini-2.0-flash-lite',
    ];

    // Filter dan pastikan riwayat percakapan strictly alternating (user -> model -> user)
    final List<Map<String, dynamic>> contents = [];
    String? lastRole;

    // Ambil maksimal 8 riwayat sebelum pesan terakhir
    final previousHistory = _history.length > 1
        ? (_history.length > 8 ? _history.sublist(_history.length - 8, _history.length - 1) : _history.sublist(0, _history.length - 1))
        : <ChatMessage>[];

    for (final item in previousHistory) {
      final role = item.isUser ? 'user' : 'model';
      final text = item.text.trim();
      if (text.isEmpty) continue;

      if (contents.isEmpty) {
        if (role == 'user') {
          contents.add({
            'role': 'user',
            'parts': [{'text': text}]
          });
          lastRole = 'user';
        }
      } else if (role == lastRole) {
        final parts = contents.last['parts'] as List;
        final currentText = parts[0]['text'] as String;
        parts[0]['text'] = '$currentText\n$text';
      } else {
        contents.add({
          'role': role,
          'parts': [{'text': text}]
        });
        lastRole = role;
      }
    }

    // Turn terakhir harus dari 'user' dengan pesan terbaru saat ini
    contents.add({
      'role': 'user',
      'parts': [{'text': message.trim()}]
    });

    final body = json.encode({
      'system_instruction': {
        'parts': [
          {
            'text': 'Kamu adalah Tbot, asisten AI resmi TimurLang. Kamu adalah pakar pendakian gunung, keselamatan di alam bebas, perlengkapan outdoor, navigasi alam, dan sistem perizinan Simaksi di Indonesia.\n\n'
                'PANDUAN PERILAKU:\n'
                '1. Jawab setiap pertanyaan seputar gunung, alam bebas, cuaca, perlengkapan, dan pendakian secara mendalam, cerdas, akurat, dan mengalir natural (BUKAN jawaban template).\n'
                '2. Gunakan gaya bahasa yang ramah, santun, hangat, dan terstruktur rapi (gunakan poin-poin tebal markdown jika menjelaskan banyak hal).\n'
                '3. Selalu utamakan keselamatan (safety first) dan prinsip kelestarian alam (Leave No Trace).\n'
                '4. Jika pengguna bertanya hal di luar alam bebas atau pendakian, tolak dengan santun dan ramah lalu ajak berdiskusi seputar rencana mendaki.'
          }
        ]
      },
      'contents': contents,
      'generationConfig': {
        'temperature': 0.7,
        'maxOutputTokens': 2048,
      }
    });

    final headers = {
      'Content-Type': 'application/json',
      'x-goog-api-key': key,
    };

    Exception? lastError;
    for (final model in candidateModels) {
      try {
        final endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$key';
        final url = Uri.parse(endpoint);

        final res = await http.post(
          url,
          headers: headers,
          body: body,
        ).timeout(const Duration(seconds: 25));

        if (res.statusCode == 200) {
          final jsonRes = json.decode(res.body);
          final text = jsonRes['candidates']?[0]?['content']?['parts']?[0]?['text'];
          if (text != null && text.toString().trim().isNotEmpty) {
            return text.toString().trim();
          }
        }
        lastError = Exception('Gemini API ($model) status ${res.statusCode}: ${res.body}');
      } catch (e) {
        lastError = Exception('Gemini API ($model) error: $e');
      }
    }

    throw lastError ?? Exception('Gagal memanggil Gemini Cloud API.');
  }

  /// Universal Intelligence Engine (Khusus Pendakian & Alam Bebas)
  String _generateUniversalResponse(String input) {
    final text = input.toLowerCase().trim();

    // 1. Sapaan & Sopan Santun
    if (text == 'halo' || text == 'hai' || text.startsWith('halo ') || text.startsWith('hai ') || text == 'p' || text == 'hi') {
      return '''**Halo! Saya Tbot, asisten AI resmi pendakian TimurLang.**

Saya siap membantu Anda seputar persiapan, informasi jalur, dan keselamatan pendakian gunung:
• **Gunung & Jalur:** Rekomendasi gunung, estimasi jalur, pos perizinan, dan karakter medan.
• **Cuaca & Alam:** Kondisi cuaca gunung, fenomena awan, dan arah navigasi.
• **Perlengkapan & Packing:** Checklist peralatan wajib, pakaian layering, logistik.
• **P3K & Keselamatan:** Penanganan cedera, hipotermia, AMS, dan keadaan darurat alam bebas.
• **Fitur TimurLang:** Registrasi Simaksi resmi, peta offline, kompas, dan suar SOS.

Ada yang ingin Anda tanyakan seputar rencana pendakian Anda?''';
    }

    if (text.contains('siapa kamu') || text.contains('kamu siapa') || text.contains('tentang kamu') || text.contains('bot apa') || text.contains('tbot')) {
      return '''**Tentang Tbot:**

Saya adalah **Tbot**, asisten virtual resmi di dalam aplikasi **TimurLang**. 

Fokus saya dikhususkan untuk memandu Anda seputar **aktivitas pendakian gunung, keselamatan di alam bebas, cuaca gunung, perlengkapan outdoor, dan sistem perizinan Simaksi**. Saya tidak melayani pertanyaan di luar konteks pendakian dan alam bebas.''';
    }

    if (text.contains('apa kabar') || text.contains('gimana kabarmu') || text.contains('sehat')) {
      return '''Alhamdulillah, saya selalu aktif dan siap membantu persiapan pendakian Anda 24/7!

Bagaimana dengan rencana pendakian Anda hari ini? Ada gunung atau jalur yang ingin Anda diskusikan?''';
    }

    if (text.contains('terima kasih') || text.contains('makasih') || text.contains('thanks') || text.contains('thx')) {
      return '''Sama-sama! Selalu utamakan keselamatan (safety first) dan lestarikan alam pegunungan kita.

Jika ada hal lain yang ingin ditanyakan seputar jalur atau perizinan Simaksi, silakan tanyakan ya!''';
    }

    // 2. Rekomendasi Gunung, Puncak Tertinggi & Informasi Gunung
    if (text.contains('tertinggi') || text.contains('puncak tertinggi') || text.contains('atap indonesia') || text.contains('7 summit') || text.contains('seven summit')) {
      return '''**Gunung Tertinggi di Indonesia (The 7 Summits of Indonesia):**

1. 🏔️ **Puncak Jaya / Carstensz Pyramid (4.884 mdpl - Papua Tengah)**
   - Puncak tertinggi di Indonesia & salah satu dari *World Seven Summits*. Menghadirkan gletser salju abadi dan dinding panjat tebing teknis (Grade 5).
2. 🌋 **Gunung Kerinci (3.805 mdpl - Jambi / Sumatra Barat)**
   - Gunung berapi aktif tertinggi di Indonesia sekaligus puncak tertinggi di Pulau Sumatra.
3. 🌋 **Gunung Rinjani (3.726 mdpl - Lombok, NTB)**
   - Gunung berapi tertinggi kedua di Indonesia dengan panorama kaldera megah dan Danau Segara Anak.
4. 🌋 **Gunung Semeru / Mahameru (3.676 mdpl - Jawa Timur)**
   - Atap Pulau Jawa dengan kawah legendaris Jonggring Saloko dan danau Ranu Kumbolo.
5. ⛰️ **Gunung Latimojong / Rante Mario (3.430 mdpl - Sulawesi Selatan)**
   - Titik tertinggi di Pulau Sulawesi dengan hutan lumut purba lebat.
6. ⛰️ **Gunung Binaiya (3.027 mdpl - Maluku / Pulau Seram)**
   - Puncak tertinggi di Kepulauan Maluku dengan medan hutan hujan tropis yang menantang.
7. ⛰️ **Bukit Raya (2.278 mdpl - Kalimantan Tengah / Barat)**
   - Titik tertinggi di wilayah Indonesia Pulau Kalimantan (Taman Nasional Bukit Baka Bukit Raya).

*Tips:* Anda dapat melihat detail jalur resmi, kuota basecamp, dan perizinan Simaksi gunung-gunung di atas melalui menu **Peta** atau **Gunung** di aplikasi TimurLang!''';
    }

    if (text.contains('tertinggi di jawa') || text.contains('atap jawa') || text.contains('gunung tertinggi jawa')) {
      return '''**Daftar Gunung Tertinggi di Pulau Jawa:**

1. **Gunung Semeru (3.676 mdpl - Jatim)** - Puncak Mahameru (Atap Pulau Jawa)
2. **Gunung Slamet (3.432 mdpl - Jateng)** - Puncak Surono (Tertinggi di Jawa Tengah)
3. **Gunung Sumbing (3.371 mdpl - Jateng)** - Puncak Rajawali
4. **Gunung Arjuno (3.339 mdpl - Jatim)** - Puncak Ogal-Agil
5. **Gunung Raung (3.332 mdpl - Jatim)** - Puncak Sejati (Kaldera Terbesar)
6. **Gunung Lawu (3.265 mdpl - Jateng/Jatim)** - Puncak Hargo Dumilah
7. **Gunung Welirang (3.156 mdpl - Jatim)**
8. **Gunung Sindoro (3.153 mdpl - Jateng)**
9. **Gunung Merbabu (3.145 mdpl - Jateng)** - Puncak Kenteng Songo
10. **Gunung Ciremai (3.078 mdpl - Jabar)** - Tertinggi di Jawa Barat''';
    }

    if (text.contains('andong')) {
      return '''**Informasi Gunung Andong (1.726 mdpl - Magelang, Jawa Tengah):**

- **Karakter:** Gunung perisai ramah pemula dan keluarga dengan pemandangan 360° spektakuler.
- **Empat Puncak Berjajar:** Puncak Makam, Puncak Jiwa, Puncak Andong (utama), dan Puncak Alap-alap.
- **Jalur Pendakian Resmi:**
  1. **Via Sawit:** Jalur paling populer dan ramai. Tersedia Jalur Lama dan Jalur Baru yang melewati Pos 1 Watu Pocong, Pos 2 Watu Gambir, Pos 3 Gambar Wayang, dan Camp Area (±1,5 - 2 jam).
  2. **Via Gogik:** Jalur alternatif suasana asri pedesaan dengan medan bebatuan.
  3. **Via Pendem:** Jalur landai dari sisi barat lereng gunung.
- **Daya Tarik:** Pemandangan lautan awan sunrise serta view gagah Merbabu, Merapi, Sindoro, dan Sumbing.''';
    }

    if (text.contains('prau')) {
      return '''**Informasi Gunung Prau (2.565 mdpl - Dataran Tinggi Dieng, Jateng):**

- **Daya Tarik:** Golden Sunrise terbaik dan hamparan Bukit Teletubbies yang luas.
- **Jalur Populer:** Patakbanteng (jalur tercepat ±2-3 jam, tangga batu), Kalilembu, Dwarawati, Wates, dan Dieng Kulon.
- **Waktu Terbaik:** Musim kemarau (Mei - September). Suhu malam bisa mencapai minus derajat (fenomena embun upas / es).''';
    }

    if (text.contains('rekomendasi gunung') || text.contains('gunung pemula') || text.contains('gunung cocok untuk pemula') || text.contains('gunung santai')) {
      return '''**Rekomendasi Gunung Cocok untuk Pemula di Jawa:**

1. **Gunung Prau (2.565 mdpl - Dieng, Jateng)**
   - Waktu tempuh: 2,5 - 4 jam
   - Daya tarik: Golden Sunrise dan Bukit Teletubbies. Jalur relatif landai via Patakbanteng atau Kalilembu.

2. **Gunung Andong (1.726 mdpl - Magelang, Jateng)**
   - Waktu tempuh: 1,5 - 2,5 jam
   - Daya tarik: Sangat ramah pemula, panorama 360° menghadap Merbabu, Merapi, Sindoro, dan Sumbing.

3. **Gunung Papandayan (2.665 mdpl - Garut, Jabar)**
   - Waktu tempuh: 3 - 4 jam
   - Daya tarik: Hutan Mati ikonik, kawah belerang, dan padang edelweis Tegal Alun.

4. **Gunung Ijen (2.386 mdpl - Banyuwangi, Jatim)**
   - Waktu tempuh: 2 - 3 jam
   - Daya tarik: Fenomena Blue Fire dan kawah asam toska memukau.

*Tips:* Pastikan selalu registrasi Simaksi resmi melalui aplikasi TimurLang sebelum mendaki.''';
    }

    if (text.contains('semeru') || text.contains('mahameru')) {
      return '''**Informasi Gunung Semeru (3.676 mdpl):**

- **Status:** Puncak tertinggi di Pulau Jawa (Atap Pulau Jawa).
- **Ikon Utama:** Ranu Kumbolo, Tanjakan Cinta, Oro-Oro Ombo, dan Kalimati.
- **Tingkat Kesulitan:** Grade 4 (Sulit - Butuh Fisik Prima).
- **Catatan Keselamatan:** Jalur puncak sering dibatasi sesuai rekomendasi PVMBG karena aktivitas vulkanik Jonggring Saloko.
- **Suhu Malam:** Bisa mencapai 0°C hingga minus (embun upas di Ranu Kumbolo).''';
    }

    if (text.contains('rinjani')) {
      return '''**Informasi Gunung Rinjani (3.726 mdpl - Lombok, NTB):**

- **Daya Tarik:** Danau Segara Anak, Gunung Barujari, dan panorama kaldera megah.
- **Jalur Populer:** Sembalun (padang savana) dan Senaru (hutan tropis).
- **Durasi Normal:** 3 hari 2 malam atau 4 hari 3 malam.
- **Tips:** Siapkan perlengkapan tahan angin kencang di Plawangan Sembalun dan summit attack berpasir terjal.''';
    }

    if (text.contains('merbabu')) {
      return '''**Informasi Gunung Merbabu (3.145 mdpl - Jawa Tengah):**

- **Jalur Populer:** Selo (Boyolali), Suwanting (Magelang), Thekelan, Wekas.
- **Pemandangan:** Padang sabana bertingkat luas dengan latar megah Gunung Merapi di seberangnya.
- **Karakter Jalur:** Jalur Selo relatif terbuka dan berdebu saat kemarau, sedangkan jalur Suwanting memiliki tanjakan fisik menantang.''';
    }

    if (text.contains('lawu')) {
      return '''**Informasi Gunung Lawu (3.265 mdpl - Perbatasan Jateng & Jatim):**

- **Jalur Populer:** Candi Cetho (savana luas & terpanjang), Cemoro Sewu (jalur bebatuan teratur & tercepat), Cemoro Kandang.
- **Ikon Utama:** Warung Mbok Yem di Hargo Dumilah, Sendang Drajat, dan Pasar Dieng.
- **Karakter Cuaca:** Terkenal memiliki suhu dingin ekstrem dan angin kencang saat musim kemarau.''';
    }

    if (text.contains('sindoro') || text.contains('sumbing')) {
      return '''**Informasi Gunung Sindoro (3.153 mdpl) & Sumbing (3.371 mdpl):**

- **Gunung Kembar Jawa Tengah:** Terletak berhadapan di Temanggung & Wonosobo.
- **Sindoro:** Jalur Kledung dan Alang-alang Sewu. Puncak memiliki kawah luas aktif belerang.
- **Sumbing:** Jalur Garung, Bowongso, Kaliangkrik. Jalur menantang dengan ikon Kawah Mati dan Puncak Rajawali.
- **Tips:** Siapkan masker/buff untuk mengantisipasi aroma belerang di sekitar puncak.''';
    }

    if (text.contains('slamet')) {
      return '''**Informasi Gunung Slamet (3.432 mdpl - Jawa Tengah):**

- **Status:** Gunung tertinggi kedua di Pulau Jawa.
- **Jalur Populer:** Bambangan (Purbalingga), Guci (Tegal), Dipajaya (Pemalang).
- **Karakter Medan:** Vegetasi hutan lebat dan jalur puncak berupa pasir/bebatuan vulkanik terjal tanpa sumber air setelah pos atas.''';
    }

    if (text.contains('gede') || text.contains('pangrango')) {
      return '''**Informasi Gunung Gede (2.958 mdpl) & Pangrango (3.019 mdpl - Jabar):**

- **Jalur Resmi:** Cibodas, Gunung Putri, dan Selabintana.
- **Ikon Utama Gede:** Alun-Alun Surya Kencana (padang edelweis 50 hektar), Telaga Biru, Air Terjun Cibeureum.
- **Ikon Utama Pangrango:** Lembah Mandalawangi yang syahdu dan tenang.
- **Perizinan:** Wajib booking Simaksi online TNGGP jauh-jauh hari karena kuota ketat.''';
    }

    // 3. Perlengkapan & Packing Mendaki
    if (text.contains('packing') || text.contains('perlengkapan') || text.contains('bawa apa') || text.contains('alat pendakian') || text.contains('tenda') || text.contains('carrier')) {
      return '''**Daftar Perlengkapan Wajib Pendakian (Checklist Outdoor):**

**1. Shelter & Istirahat:**
- Tenda double-layer dengan frame kokoh
- Sleeping bag (comfort rating 5°C - 10°C)
- Matras aluminium foil / matras tiup insulasi
- Flysheet tambahan untuk pelindung angin/hujan

**2. Pakaian (Prinsip 3-Layer System):**
- Base layer (baju sintetis/quick-dry, jangan katun tebal)
- Mid layer (fleece / jaket thermal insulasi)
- Outer layer (jaket waterproof & windbreaker Gore-Tex)
- Jas hujan (ponco atau setelan)
- Sarung tangan polar/waterproof, buff, & kupluk hangat

**3. Navigasi & Penerangan:**
- Headlamp + baterai cadangan
- Aplikasi TimurLang (peta offline & kompas)

**4. Logistik & Masak:**
- Kompor lapangan + gas canister
- Nesting & alat makan
- Air minum (minimal 2-3 liter per orang) + makanan padat kalori

**5. Medis & Keselamatan:**
- Kotak P3K standar & obat pribadi
- Peluit darurat (emergency whistle)''';
    }

    if (text.contains('etika') || text.contains('leave no trace') || text.contains('aturan mendaki') || text.contains('sampah')) {
      return '''**Prinsip Dasar "Leave No Trace" (Etika Pendaki Gunung):**

1. **Rencanakan dan persiapkan matang-matang:** Cek kuota, izin Simaksi, dan ramalan cuaca.
2. **Berjalan dan berkemah di jalur yang sudah ada:** Jangan membuat jalur pintas atau merusak tanaman.
3. **Bawa pulang seluruh sampah Anda:** Jangan meninggalkan sampah plastik, tisu basah, atau puntung rokok.
4. **Tinggalkan apa yang Anda temukan:** Dilarang keras memetik bunga edelweis atau mencoret batu/pohon (vandalisme).
5. **Kurangi dampak api unggun:** Hindari membuat api unggun di area rawan kebakaran hutan pegunungan.
6. **Hormati satwa liar:** Jangan memberi makan hewan di gunung dan amankan logistik makanan di dalam tenda.
7. **Hargai pendaki lain:** Jaga ketenangan, jangan memutar musik speaker kencang di camp area.''';
    }

    // 4. Cuaca Gunung & Fenomena Alam
    if (text.contains('cuaca') || text.contains('awan') || text.contains('hujan') || text.contains('petir') || text.contains('badai') || text.contains('angin')) {
      return '''**Memahami Fenomena Cuaca di Alam Bebas & Gunung:**

- **Awan Kumulonimbus (Cb):** Awan hitam pekat menjulang tinggi seperti menara. Pertanda badai petir dan angin kencang. Jika melihat awan ini mendekat, **segera turun dari puncak atau punggungan terbuka.**
- **Awan Lentikularis (Topi Awan):** Awan berbentuk piring melayang di atas puncak gunung. Mengindikasikan badai angin kencang berkecepatan ekstrem di puncak.
- **Ketinggian vs Suhu (Lapse Rate):** Setiap kenaikan elevasi 100 meter, suhu udara alami akan turun sekitar 0.6°C - 0.65°C.

*Tips:* Gunakan menu **Informasi Cuaca** di aplikasi TimurLang untuk memantau data satelit live lokasi pendakian Anda.''';
    }

    // 5. Fitur TimurLang & Simaksi
    if (text.contains('timurlang') || text.contains('aplikasi ini') || text.contains('cara pakai') || text.contains('fitur')) {
      return '''**Panduan Fitur Aplikasi TimurLang untuk Pendaki:**

1. **Informasi Cuaca:** Terintegrasi API satelit real-time berdasarkan GPS presisi elevasi Anda.
2. **Siaga SOS & Deteksi Jatuh:** Sensor akselerometer mendeteksi benturan hebat secara otomatis dan memancarkan suar darurat SAR.
3. **Peta Offline & Jalur:** Navigasi jalur pendakian tanpa memerlukan sinyal internet.
4. **Kompas 3D Digital:** Penunjuk arah mata angin kardinal dengan kalibrasi sensor gyroscope.
5. **Booking Simaksi Terpadu:** Pengajuan izin pendakian resmi dengan validasi kuota harian pos basecamp.
6. **Rekam Medis Darurat:** Informasi golongan darah dan kontak keluarga darurat yang siap diakses penyelamat SAR.''';
    }

    if (text.contains('simaksi') || text.contains('booking') || text.contains('izin') || text.contains('tiket')) {
      return '''**Cara Pengajuan Simaksi di TimurLang:**

1. Buka menu **Gunung** di beranda aplikasi TimurLang atau pilih gunung tujuan Anda.
2. Pastikan kuota harian masih tersedia dan jalur berstatus **"Buka"**.
3. Ketuk tombol **"Booking Simaksi"**.
4. Lengkapi formulir tanggal naik, tanggal turun, pos basecamp, serta jumlah anggota rombongan.
5. Lanjutkan ke verifikasi dan selesaikan pembayaran untuk mendapatkan e-Tiket resmi dengan kode hash validasi.''';
    }

    // 6. Latihan Fisik & Kesehatan Mendaki
    if (text.contains('latihan fisik') || text.contains('olahraga') || text.contains('persiapan fisik') || text.contains('jogging')) {
      return '''**Panduan Latihan Fisik Sebelum Pendakian:**

Lakukan latihan rutin 2-3 minggu sebelum naik gunung:
1. **Latihan Kardio (3-4x seminggu):**
   - Jogging santai 30-45 menit untuk membangun kapasitas paru-paru (VO2 Max).
   - Naik-turun tangga gedung/jembatan untuk melatih otot paha dan betis.
2. **Latihan Kekuatan (Strength Training):**
   - Squats, lunges, dan calf raises untuk memperkuat sendi lutut dan tungkai.
   - Plank dan core workout untuk kestabilan punggung saat membawa carrier berat.
3. **Simulasi Carrier:**
   - Berjalan kaki sambil membawa tas ransel berisi beban 5-8 kg untuk membiasakan postur tubuh.''';
    }

    if (text.contains('ams') || text.contains('mountain sickness') || text.contains('penyakit ketinggian') || text.contains('aklimatisasi')) {
      return '''**Memahami Acute Mountain Sickness (AMS):**

AMS terjadi akibat tubuh belum sempat beraklimatisasi dengan penurunan tekanan oksigen di ketinggian (>2.400 mdpl).

- **Gejala Umum:** Pusing/sakit kepala berdenyut, mual, kehilangan nafsu makan, badan lemas luar biasa, sulit tidur.
- **Pencegahan:**
  1. Naik perlahan (Climb high, sleep low).
  2. Perbanyak minum air putih (minimal 3 liter/hari, hindari dehidrasi).
  3. Hindari konsumsi alkohol atau obat tidur di gunung.
- **Penanganan:**
  - Istirahat dan jangan lanjutkan perjalanan naik.
  - Jika gejala memburuk atau mengalami sesak napas -> **SEGERA EVAKUASI TURUN KE ELEVASI LEBIH RENDAH.**''';
    }

    // 7. P3K & Keselamatan di Alam Bebas
    if (text.contains('hipotermia') || text.contains('kedinginan') || text.contains('menggigil')) {
      return '''**Penanganan Darurat Hipotermia di Gunung:**

1. **Cegah paparan angin:** Segera masukkan korban ke dalam tenda tertutup.
2. **Lepas pakaian basah:** Ganti seluruh pakaian yang lembap dengan pakaian kering hangat.
3. **Hangatkan tubuh bertahap:** Masukkan ke dalam sleeping bag berlapis, gunakan matras aluminium agar tidak bersentuhan langsung dengan tanah dingin.
4. **Berikan asupan hangat:** Berikan air manis hangat (teh manis/madu hangat) jika korban sadar penuh.
5. **Skin-to-skin contact:** Jika kondisi parah, masuk bersama pendamping ke dalam sleeping bag untuk mentransfer panas tubuh.''';
    }

    if (text.contains('luka') || text.contains('berdarah')) {
      return '''**Penanganan Luka Terbuka di Jalur:**

1. Hentikan pendarahan dengan menekan luka menggunakan kain kasa bersih selama 10-15 menit.
2. Bersihkan sekitar luka dengan air mengalir bersih.
3. Oleskan antiseptik (povidone iodine) dan tutup rapat dengan perban steril.''';
    }

    if (text.contains('patah') || text.contains('fraktur') || text.contains('terkilir') || text.contains('keseleo')) {
      return '''**Penanganan Dugaan Patah Tulang / Terkilir:**

1. Istirahatkan bagian tubuh yang cedera, jangan dipaksa berjalan.
2. Buat bidai penyangga darurat menggunakan ranting pohon lurus atau trekking pole yang diikat dengan kain mitela/buff.
3. Kompres dingin untuk meredakan bengkak jika tersedia air es.''';
    }

    if (text.contains('ular') || text.contains('gigitan ular') || text.contains('hewan')) {
      return '''**Penanganan Gigitan Ular Berbisa:**

1. Tenangkan korban dan minimalkan gerakan tubuh agar racun tidak cepat menyebar ke peredaran darah.
2. Posisikan area gigitan lebih rendah dari posisi jantung.
3. **JANGAN PERNAH** mengiris luka, menyedot racun dengan mulut, atau mengompres es batu.
4. Segera hubungi basecamp via fitur SOS TimurLang untuk evakuasi darurat medis.''';
    }

    // 8. Default: Tolak Topik di Luar Konteks Pendakian
    return 'Maaf, saya adalah Tbot, asisten khusus **pendakian gunung dan alam bebas TimurLang**.\n\n'
        'Saya hanya dapat membantu Anda menjawab hal-hal seputar:\n'
        '• Rekomendasi gunung & informasi jalur pendakian di Indonesia\n'
        '• Perlengkapan mendaki, checklist packing, & pakaian outdoor\n'
        '• Prakiraan cuaca gunung & navigasi alam (kompas & peta)\n'
        '• Pertolongan Pertama (P3K), pencegahan Hipotermia & gejala AMS\n'
        '• Panduan perizinan Simaksi dan fitur aplikasi TimurLang\n\n'
        'Silakan tanyakan hal-hal yang berkaitan dengan persiapan atau aktivitas pendakian Anda!';
  }

  /// Clear chat history
  void clearHistory() {
    _history.clear();
  }
}

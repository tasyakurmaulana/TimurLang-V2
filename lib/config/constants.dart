// ============================================
// TimurLang - Constants Configuration
// ============================================

import 'dart:convert';

class AppConstants {
  // App Info
  static const String appName = 'TimurLang';
  static const String appTagline = 'Perizinan & Keselamatan Pendakian Terpadu';
  static const String appVersion = '0.1.0';

  // Database
  static const String dbName = 'timurlang.db';
  static const int dbVersion = 7;

  // Session
  static const String sessionTokenKey = 'session_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';
  static const String rememberMeKey = 'remember_me';
  // ⏱️ SESSION TIMEOUT: Ubah angka di bawah untuk mengatur durasi sesi (dalam menit)
  // Contoh: 1 = 1 menit, 60 = 1 jam, 1440 = 1 hari, 4320 = 3 hari
  static const int sessionExpiryMinutes = 600;
  static const String biometricEnabledKey = 'biometric_enabled';
  static const String lastBiometricUserIdKey = 'last_biometric_user_id';
  static const String registeredBiometricUserIdsKey =
      'registered_biometric_user_ids';

  // ==========================================================================
  // 💳 [KODINGAN KONFIGURASI MIDTRANS: SERVER KEY, CLIENT KEY & URL SNAP]
  // --------------------------------------------------------------------------
  // Kunci API resmi untuk gateway pembayaran Midtrans Sandbox / Production
  // ==========================================================================
  // Midtrans Payment Gateway
  // Otomatis terdeteksi Production jika Server Key bukan Sandbox (tidak berawalan SB-)
  static bool get midtransIsProduction =>
      midtransServerKey.startsWith('Mid-') &&
      !midtransServerKey.startsWith('SB-');
  // Masukkan Server Key Midtrans Anda (Contoh: SB-Mid-server-XXXXX)
  static const String midtransServerKey = 'SB-Mid-server-ggpA~I8KRa3j6U9d4~Urilpf';
  // Masukkan Client Key Midtrans Anda (Contoh: SB-Mid-client-XXXXX)
  static const String midtransClientKey = 'SB-Mid-client-DSuywWCiN0pxVMZKepEY2_UW';
  static String get midtransSnapUrl => midtransIsProduction
      ? 'https://app.midtrans.com/snap/v1/transactions'
      : 'https://app.sandbox.midtrans.com/snap/v1/transactions';
  static String get midtransApiBaseUrl => midtransIsProduction
      ? 'https://api.midtrans.com/v2'
      : 'https://api.sandbox.midtrans.com/v2';

  // AI Chatbot (Tbot) Configuration
  static final String aiApiKey = String.fromCharCodes([
    103, 115, 107, 95, 99, 102, 120, 84, 49, 52, 83, 103, 51, 84, 106, 50,
    79, 88, 121, 102, 72, 103, 100, 113, 87, 71, 100, 121, 98, 51, 70, 89,
    50, 111, 73, 84, 82, 73, 49, 102, 88, 69, 48, 121, 97, 79, 57, 83,
    122, 102, 111, 85, 113, 65, 117, 68
  ]);
  static String get geminiApiKey => aiApiKey;

  // Fall Detection
  static const double fallThresholdG = 2.5; // G-force threshold
  static const int fallCountdownSeconds = 15;
  static const double fallFreefallThreshold = 0.3;
  static const String sosMonitoringEnabledKey = 'sos_monitoring_enabled';

  // Operational Hours
  static const int operationalStartHour = 8;
  static const int operationalEndHour = 18;
  static const int sunsetWarningMinutes = 120; // 2 jam sebelum

  // Currency Rates (mock offline)
  static const Map<String, double> defaultCurrencyRates = {
    'IDR': 1.0,
    'USD': 0.0000625, // 1 IDR = ~0.0000625 USD
    'EUR': 0.0000575,
    'GBP': 0.0000494,
  };

  // Timezone offsets
  static const Map<String, int> timezoneOffsets = {
    'WIB': 7,
    'WITA': 8,
    'WIT': 9,
    'UTC': 0,
  };

  // Mountain Grades
  static const List<String> mountainGrades = [
    'Grade 1 - Mudah',
    'Grade 2 - Sedang',
    'Grade 3 - Sulit',
    'Grade 4 - Sangat Sulit',
    'Grade 5 - Ekstrem',
  ];

  // User Roles
  static const String rolePendaki = 'pendaki';
  static const String roleBasecamp = 'basecamp';

  // Sync Status
  static const String syncPending = 'menunggu_sinkronisasi';
  static const String syncCompleted = 'tersinkronisasi';
  static const String syncFailed = 'gagal';

  // Simaksi Status
  static const String statusDiajukan = 'Diajukan';
  static const String statusTerdaftar = 'Terdaftar';
  static const String statusTervalidasi = 'Tervalidasi';
  static const String statusDiJalur = 'Di Jalur';
  static const String statusSelesai = 'Selesai';
  static const String statusDitolak = 'Ditolak';
  static const String statusDibatalkan = 'Dibatalkan';
  static const String statusDibatalkanPendaki = 'Dibatalkan (Non-Refund)';
  static const String statusDibatalkanBasecamp = 'Dibatalkan Pengelola';
  static const String statusRescheduled = 'Jadwal Diubah';
  static const String statusRefundDiajukan = 'Refund Diajukan';
  static const String statusRefundSelesai = 'Refund Selesai';

  // Trail Status
  static const String trailOpen = 'Buka';
  static const String trailClosed = 'Tutup';
  static const String trailWarning = 'Waspada Cuaca Ekstrem';

  // SOS Types
  static const String sosFallDetection = 'fall_detection';
  static const String sosManual = 'manual';

  // SOS Handling Status
  static const String sosActive = 'darurat_aktif';
  static const String sosHandled = 'ditangani';
  static const String sosCancelled = 'dibatalkan';
}

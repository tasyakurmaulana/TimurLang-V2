# DOKUMEN SPESIFIKASI KEBUTUHAN PERANGKAT LUNAK (SKPL)
## SOFTWARE REQUIREMENTS SPECIFICATION (SRS)

---

| **Informasi Dokumen** | **Detail** |
| :--- | :--- |
| **Nama Proyek** | **TimurLang** - *Sistem Informasi Perizinan & Keselamatan Pendakian Terpadu* |
| **Kategori Aplikasi** | Mobile Application (Flutter - Android / iOS) with Dual Database & Blockchain Security |
| **Nomor Dokumen** | SKPL-TIMURLANG-2026-V1.0 |
| **Versi Dokumen** | 1.0.0 |
| **Tanggal Pembuatan** | 24 Oktober 2026 |
| **Penyusun** | Tim Pengembang Mobile Semester 5 |
| **Target Pembaca** | Dosen Penguji, Analis Sistem, Pengembang Aplikasi, Desainer UML/Arsitek Sistem |

---

## DAFTAR ISI
1. [BAB 1: PENDAHULUAN](#bab-1-pendahuluan)
   - 1.1 Tujuan Penulisan Dokumen
   - 1.2 Lingkup Produk
   - 1.3 Definisi, Akronim, dan Singkatan
   - 1.4 Referensi Standar
   - 1.5 Gambaran Umum Dokumen
2. [BAB 2: DESKRIPSI UMUM SISTEM](#bab-2-deskripsi-umum-sistem)
   - 2.1 Perspektif Produk & Arsitektur Tingkat Tinggi
   - 2.2 Karakteristik dan Klasifikasi Pengguna (Aktor)
   - 2.3 Lingkungan Operasi & Batasan Desain
   - 2.4 Asumsi dan Ketergantungan
3. [BAB 3: KEBUTUHAN FUNGSIONAL SISTEM (FUNCTIONAL REQUIREMENTS)](#bab-3-kebutuhan-fungsional-sistem)
   - 3.1 Modul 1: Autentikasi, Keamanan & Profil Pengguna
   - 3.2 Modul 2: Eksplorasi Gunung, Kuota & Informasi Cuaca
   - 3.3 Modul 3: Manajemen Perizinan Pendakian (SIMAKSI)
   - 3.4 Modul 4: Gateway Pembayaran & Tiket Blockchain
   - 3.5 Modul 5: Navigasi, Jalur & Peta Offline (GIS)
   - 3.6 Modul 6: Sistem Tanggap Darurat & Keselamatan (SOS & Sensor)
   - 3.7 Modul 7: Operasional Petugas Basecamp / Ranger
   - 3.8 Modul 8: Asisten Kecerdasan Buatan (Gemini AI Survival Assistant)
   - 3.9 Modul 9: Sinkronisasi Offline-First & Realtime Cloud
   - 3.10 Modul 10: Gamifikasi & Evaluasi Pengguna
4. [BAB 4: KEBUTUHAN NON-FUNGSIONAL SISTEM (NON-FUNCTIONAL REQUIREMENTS)](#bab-4-kebutuhan-non-fungsional-sistem)
   - 4.1 Parameter Kinerja (Performance)
   - 4.2 Keandalan & Ketersediaan (Reliability & Availability)
   - 4.3 Keamanan Sistem (Security)
   - 4.4 Kemudahan Penggunaan (Usability)
   - 4.5 Portabilitas & Kompatibilitas
5. [BAB 5: PANDUAN LENGKAP PEMETAAN PERANCANGAN DIAGRAM UML](#bab-5-panduan-lengkap-pemetaan-perancangan-diagram-uml)
   - 5.1 Use Case Diagram (Identifikasi Aktor & Usecase Matrix)
   - 5.2 Spesifikasi Skenario Use Case Utama (Normal & Alternative Flow)
   - 5.3 Class Diagram (Struktur Kelas, Atribut, Metode & Relasi Antar Kelas)
   - 5.4 Activity Diagram (Alur Kerja Operasional Utama)
   - 5.5 Sequence Diagram (Interaksi Antar Komponen / Objek)
   - 5.6 State Machine Diagram (Lifecycle Siklus Hidup Tiket & SOS)
   - 5.7 Deployment Diagram (Topologi Fisik Perangkat Keras & Jaringan)
6. [BAB 6: SPESIFIKASI BASIS DATA (DATA DICTIONARY)](#bab-6-spesifikasi-basis-data)
7. [BAB 7: MATRIKS KETERLACAKAN KEBUTUHAN (TRACEABILITY MATRIX)](#bab-7-matriks-keterlacakan-kebutuhan)

---

# BAB 1: PENDAHULUAN

### 1.1 Tujuan Penulisan Dokumen
Dokumen Spesifikasi Kebutuhan Perangkat Lunak (SKPL) ini disusun sebagai dokumen formal spesifikasi rekayasa perangkat lunak untuk aplikasi **TimurLang**. Dokumen ini bertujuan:
1. Mendefinisikan seluruh kebutuhan fungsional dan non-fungsional sistem secara komprehensif, terstruktur, dan terukur.
2. Menjadi acuan baku bagi perancangan diagram **UML (Unified Modeling Language)**, meliputi *Use Case Diagram, Class Diagram, Activity Diagram, Sequence Diagram, State Machine Diagram*, hingga *Deployment Diagram*.
3. Menjadi pedoman implementasi kode, pengujian (*testing*), serta penyusunan laporan akhir tugas/projek Rekayasa Perangkat Lunak & Pemrograman Mobile.

### 1.2 Lingkup Produk
Aplikasi **TimurLang** adalah aplikasi mobile berbasis Flutter yang dirancang sebagai ekosistem keselamatan dan perizinan pendakian gunung terpadu. Sistem ini menjembatani pendaki (*hikers*) dan pengelola pos pendakian (*basecamp ranger*). Fitur utama mencakup:
- Pengurusan Surat Izin Masuk Kawasan Konservasi (**SIMAKSI**) secara digital.
- Pembayaran terintegrasi via Payment Gateway (Midtrans) dan penerbitan tiket yang dijamin keasliannya melalui teknologi **Blockchain (Polygon Amoy Testnet)**.
- Navigasi jalur pendakian berbasis peta offline (OpenStreetMap) dan kompas digital untuk area tanpa sinyal seluler (*blank spot*).
- Sistem keselamatan aktif (*Emergency SOS*) dengan sirine suara, sinyal koordinat real-time, serta **Deteksi Jatuh Otomatis (*Fall Detection*)** memanfaatkan sensor *accelerometer*.
- Asisten konsultasi pertolongan pertama dan teknik survival berbasis kecerdasan buatan (**Google Gemini AI**).
- Dashboard operasional basecamp untuk monitoring pendaki aktif, verifikasi tiket QR-Code, dan manajemen jalur/pos.
- Sinkronisasi data hybrid (*offline-first* dengan SQLite lokal dan Supabase PostgreSQL di cloud).

### 1.3 Definisi, Akronim, dan Singkatan
| Istilah / Akronim | Penjelasan / Definisi |
| :--- | :--- |
| **SKPL / SRS** | Spesifikasi Kebutuhan Perangkat Lunak / *Software Requirements Specification* standar IEEE 830. |
| **SIMAKSI** | Surat Izin Masuk Kawasan Konservasi; surat izin resmi untuk melakukan pendakian gunung di Indonesia. |
| **UML** | *Unified Modeling Language*; standar pemodelan visual untuk perancangan sistem berorientasi objek. |
| **SOS** | *Save Our Souls*; sinyal panggilan darurat bahaya. |
| **GIS / GPS** | *Geographic Information System* / *Global Positioning System*. |
| **Fall Detection** | Algoritma deteksi benturan/jatuh menggunakan sensor akselerometer dan giroskop smartphone. |
| **Blockchain** | Buku besar terdistribusi yang bersifat *immutable* (tidak dapat dimanipulasi). Dalam TimurLang menggunakan Polygon Amoy Testnet. |
| **Smart Contract / Web3** | Protokol transaksi terprogram di atas jaringan blockchain terdesentralisasi. |
| **RLS** | *Row Level Security*; lapisan keamanan kontrol akses data per baris pada PostgreSQL/Supabase. |
| **Offline-First** | Paradigma aplikasi yang tetap beroperasi penuh tanpa internet dengan menyimpan data di SQLite lokal dan melakukan sinkronisasi otomatis (*sync queue*) saat koneksi tersedia. |

### 1.4 Referensi Standar
- IEEE Std 830-1998: *IEEE Recommended Practice for Software Requirements Specifications*.
- ISO/IEC/IEEE 29148:2018: *Systems and software engineering — Life cycle processes — Requirements engineering*.
- Standar Dokumentasi Rekayasa Perangkat Lunak Jurusan Teknik Informatika / Sistem Informasi.

### 1.5 Gambaran Umum Dokumen
Dokumen ini disusun menjadi 7 bab utama yang merinci seluruh aspek kebutuhan fungsional dan teknis, model relasi data, hingga panduan pemetaan notasi diagram UML untuk mempermudah penyusunan laporan proyek.

---

# BAB 2: DESKRIPSI UMUM SISTEM

### 2.1 Perspektif Produk & Arsitektur Tingkat Tinggi
Aplikasi TimurLang mengadopsi arsitektur **Multi-Tier Client-Server & Decentralized Hybrid**:
1. **Presentation Layer (Mobile Client)**: Antarmuka Flutter (Dart) yang responsif dan berjalan pada perangkat Android/iOS, mengintegrasikan sensor perangkat (*Compass, Accelerometer, GPS, Biometric*).
2. **Local Persistence Layer (Offline Storage)**: SQLite Database (`timurlang.db`) dengan mekanisme antrean sinkronisasi (`sync_queues`) saat pengguna berada di area pegunungan minim sinyal.
3. **Backend & Cloud Layer**: Supabase Backend-as-a-Service (PostgreSQL, Authentication, Realtime WebSocket Engine, Row Level Security).
4. **Third-Party Services**:
   - **Payment Gateway**: Midtrans Snap API (Virtual Account, QRIS, E-Wallet).
   - **Public Blockchain**: Polygon Amoy Testnet RPC Node (ChainID: 80002) via Web3dart untuk pencatatan *hash* tiket permanen.
   - **AI Engine**: Google Gemini Pro Generative AI API untuk modul *Survival Assistant*.
   - **Weather Data Provider**: BMKG / OpenWeatherMap API untuk prakiraan cuaca gunung.

### 2.2 Karakteristik dan Klasifikasi Pengguna (Aktor)
Sistem TimurLang melibatkan 3 (tiga) aktor utama:

| No | Aktor | Deskripsi & Hak Akses |
| :---: | :--- | :--- |
| 1 | **Pendaki (Hiker)** | Pengguna umum aplikasi mobile. Memiliki wewenang mendaftar akun, melengkapi profil medis dan KTP, menelusuri katalog gunung, mengajukan izin SIMAKSI, membayar tiket secara digital, menggunakan peta offline & kompas, mengaktifkan SOS & Fall Detection, berkonsultasi dengan AI Survival, serta memberikan ulasan. |
| 2 | **Petugas Basecamp (Ranger)** | Pengelola pos pendakian di kaki gunung. Memiliki wewenang mengakses Dashboard Basecamp, memindai dan memverifikasi QR Code tiket pendaki saat *check-in* dan *check-out*, memantau daftar pendaki yang sedang berada di atas gunung (*active hiker tracking*), memantau log insiden SOS masuk, serta memperbarui status jalur/kuota pos. |
| 3 | **Sistem Eksternal (System Aktor)** | Layanan pihak ketiga yang berinteraksi secara otomatis: Gateway Midtrans, Smart Contract Polygon Blockchain, Supabase Sync Engine, Google Gemini AI API, dan Sensor Perangkat Fisik (GPS, Akselerometer, Biometrik). |

### 2.3 Lingkungan Operasi & Batasan Desain
- **Sistem Operasi Klien**: Android versi 8.0 (Oreo) ke atas / iOS versi 13 ke atas.
- **Hardware Requirement**: Memiliki modul GPS, Sensor Akselerometer/Giroskop, Sensor Magnetometer (Kompas), Kamera (untuk scan QR & upload identitas), dan Sensor Sidik Jari/Face ID (opsional untuk biometrik).
- **Kondisi Jaringan**: Mampu bekerja dalam dua mode: *Online Mode* (sinkronisasi cloud dan pembayaran) dan *Offline Mode* (navigasi peta, kompas, alarm darurat lokal, dan pencatatan riwayat).

---

# BAB 3: KEBUTUHAN FUNGSIONAL SISTEM

Setiap kebutuhan fungsional memiliki kode unik dengan format: **SKPL-F-[NOMOR]**.

### 3.1 Modul 1: Autentikasi, Keamanan & Profil Pengguna
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-01** | Registrasi Akun | Sistem memungkinkan pengguna baru membuat akun dengan menginput Nama Lengkap, Email, Password, dan memilih peran (*Pendaki* atau *Petugas Basecamp*). Password di-hash menggunakan SHA-256. | Pendaki, Petugas |
| **SKPL-F-02** | Login Akun Standar | Pengguna melakukan autentikasi menggunakan Email dan Password terdaftar. Jika valid, sistem menerbitkan session token lokal dan cloud. | Pendaki, Petugas |
| **SKPL-F-03** | Login Biometrik | Pengguna dapat mengaktifkan dan melakukan login cepat menggunakan sensor sidik jari (*fingerprint*) atau pengenalan wajah (*face unlock*) via `local_auth`. | Pendaki, Petugas |
| **SKPL-F-04** | Pengelolaan Data Pribadi (KYC) | Pendaki wajib melengkapi data identitas resmi (Kewarganegaraan WNI/WNA, Jenis Identitas KTP/Paspor/SIM, Nomor Identitas, Foto Identitas, TTL, Jenis Kelamin, Nomor HP, Nomor Kontak Darurat, dan Alamat Lengkap Domisili). | Pendaki |
| **SKPL-F-05** | Pengelolaan Rekam Medis (*Medical Profile*) | Pendaki dapat menyimpan informasi medis vital: Golongan Darah (A, B, AB, O), Riwayat Penyakit Khusus (asma, jantung, dll.), Riwayat Alergi, Nama Kontak Darurat, dan Nomor Telepon Kontak Darurat sebagai data tanggap darurat SAR. | Pendaki |
| **SKPL-F-06** | Logout & Manajemen Sesi | Pengguna dapat mengakhiri sesi aktif. Sistem menghapus token sesi lokal dan membersihkan cache kredensial sensitif. | Pendaki, Petugas |

### 3.2 Modul 2: Eksplorasi Gunung, Kuota & Informasi Cuaca
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-07** | Katalog Informasi Gunung | Menampilkan daftar gunung di Indonesia beserta elevasi (mdpl), tingkat kesulitan teknis (*Grade 1 - 3*), ketersediaan sumber air, koordinat geografis, deskripsi, foto gunung, dan status jalur (*Buka / Tutup / Waspada*). | Pendaki, Petugas |
| **SKPL-F-08** | Monitoring Kuota Harian | Sistem menampilkan sisa kuota pendaki per hari pada masing-masing gunung untuk mencegah *overcapacity*. | Pendaki, Petugas |
| **SKPL-F-09** | Prakiraan Cuaca Gunung | Sistem menyajikan informasi cuaca real-time di sekitar koordinat gunung (suhu udara, kecepatan angin, kelembapan, status hujan/badai) yang diperbarui secara berkala. | Pendaki |

### 3.3 Modul 3: Manajemen Perizinan Pendakian (SIMAKSI)
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-10** | Pengajuan Izin SIMAKSI | Pendaki mengisi formulir izin pendakian: memilih gunung tujuan, basecamp/jalur masuk, tanggal naik, tanggal turun, jumlah anggota rombongan, serta daftar nama dan kontak darurat setiap anggota. | Pendaki |
| **SKPL-F-11** | Validasi Syarat SIMAKSI | Sistem secara otomatis memvalidasi kelengkapan data pribadi (KTP) dan profil medis ketua rombongan sebelum formulir dapat diproses ke tahap pembayaran. | Sistem |
| **SKPL-F-12** | Penerbitan E-Tiket SIMAKSI | Setelah pembayaran diverifikasi, sistem menerbitkan E-Tiket berformat digital yang memuat ID Izin unik, detail rombongan, masa berlaku izin, serta **QR Code dinamis** untuk verifikasi offline/online. | Pendaki, Sistem |
| **SKPL-F-13** | Riwayat Perizinan | Pendaki dapat melihat riwayat izin SIMAKSI berstatus *Diajukan, Terbayar, Aktif (Check-in), Selesai (Check-out)*, atau *Dibatalkan*. | Pendaki |

### 3.4 Modul 4: Gateway Pembayaran & Tiket Blockchain
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-14** | Pembayaran Digital (Midtrans) | Sistem mengintegrasikan Midtrans Snap UI melalui WebView untuk memproses tagihan tiket pendakian melalui Bank Transfer (Virtual Account), QRIS, GoPay, ShopeePay, dan Kartu Kredit. | Pendaki, Midtrans |
| **SKPL-F-15** | Pencatatan Tiket di Blockchain | Sistem melakukan *hashing* data izin SIMAKSI (SHA-256 + nonce) dan menyiarkan (*broadcast*) transaksi verifikasi ke jaringan **Polygon Amoy Testnet (ChainID: 80002)** melalui relayer resmi TimurLang menggunakan `web3dart`. | Sistem, Blockchain |
| **SKPL-F-16** | Eksplorasi Bukti Transaksi Web3 | Pendaki dan Petugas dapat memverifikasi keabsahan tiket secara publik melalui tautan PolygonScan Explorer (`https://amoy.polygonscan.com/tx/[hash]`). | Pendaki, Petugas |

### 3.5 Modul 5: Navigasi, Jalur & Peta Offline (GIS)
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-17** | Peta Jalur Pendakian Interaktif | Menampilkan visualisasi peta topografi OpenStreetMap menggunakan `flutter_map` dan `latlong2`, lengkap dengan rute garis jalur (*trail polyline*), pos pendakian, shelter, sumber mata air, dan puncak. | Pendaki |
| **SKPL-F-18** | Mode Peta Offline | Peta dapat diakses dan digunakan secara optimal tanpa jaringan internet melalui penyimpanan lokal (*cached tiles & local geojson*). | Pendaki |
| **SKPL-F-19** | Posisi Real-time (GPS Tracker) | Sistem membaca koordinat GPS perangkat secara akurat menggunakan `geolocator` untuk menampilkan posisi terkini pendaki di atas jalur peta. | Pendaki |
| **SKPL-F-20** | Kompas Digital | Menyediakan instrumen navigasi kompas digital menggunakan sensor magnetometer perangkat (`flutter_compass`) dengan tampilan sudut azimut (*degree*) dan mata angin untuk penentuan arah di alam bebas. | Pendaki |

### 3.6 Modul 6: Sistem Tanggap Darurat & Keselamatan (SOS & Sensor)
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-21** | Pemicu Tombol SOS Manual (*SOS Beacon*) | Pendaki dapat menekan tombol panik SOS. Sistem akan menyalakan alarm audio bervolume tinggi (*siren player*), menyalakan visual beacon berkedip, dan mengambil koordinat GPS terkini. | Pendaki |
| **SKPL-F-22** | Deteksi Jatuh Otomatis (*Fall Detection*) | Sistem memantau accelerometer dan gyroscope melalui `sensors_plus`. Jika terdeteksi gaya gravitasi ekstrim (*sudden impact spike*) disusul fase tidak bergerak, sistem menyalakan hitung mundur 15 detik sebelum otomatis memancarkan status SOS. | Pendaki, Sistem |
| **SKPL-F-23** | Siaran Darurat ke Basecamp (Realtime) | Insiden SOS secara otomatis diunggah ke database Supabase dan disiarkan secara instan (*WebSocket channel*) ke dashboard petugas basecamp terdekat, mencakup nama pendaki, kontak darurat, golongan darah, riwayat penyakit, dan koordinat maps. | Sistem, Petugas |
| **SKPL-F-24** | SMS / Pesan Cepat Kontak Darurat | Sistem menyediakan tombol darurat langsung untuk membuka aplikasi pengirim pesan/telepon ke nomor kontak darurat keluarga dan nomor SAR lokal dengan pesan teks darurat terformat otomatis beserta tautan Google Maps. | Pendaki |

### 3.7 Modul 7: Operasional Petugas Basecamp / Ranger
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-25** | Dashboard Operasional Basecamp | Petugas dapat melihat ringkasan statistik harian: jumlah pendaki naik hari ini, jumlah pendaki turun, kuota tersisa, dan daftar peringatan aktif. | Petugas |
| **SKPL-F-26** | Pemindai QR Tiket (*Ticket Verification*) | Petugas menggunakan kamera perangkat (`mobile_scanner`) untuk memindai QR Code tiket pendaki guna memvalidasi identitas, tanggal izin, dan keaslian blok hash izin. | Petugas |
| **SKPL-F-27** | Proses Check-In & Check-Out | Petugas mengubah status pendaki menjadi *Check-In* saat mulai naik, dan *Check-Out* saat tiba kembali di basecamp untuk memastikan tidak ada pendaki tertinggal di gunung. | Petugas |
| **SKPL-F-28** | Monitoring Pendaki Aktif (*Hiker Monitor*) | Menampilkan daftar seluruh rombongan pendaki yang saat ini masih berada di atas jalur pendakian beserta durasi pendakian dan status keamanannya. | Petugas |
| **SKPL-F-29** | Manajemen Pos & Checkpoint Jalur | Petugas dapat menambah, mengubah, atau memperbarui informasi pos pendakian, ketersediaan air, dan peringatan bahaya di jalur. | Petugas |

### 3.8 Modul 8: Asisten Kecerdasan Buatan (Gemini AI Survival Assistant)
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-30** | Chatbot Survival & P3K Gunung | Pendaki dapat berkonsultasi interaktif melalui chatbot kecerdasan buatan berbasis Google Gemini API mengenai penanganan darurat hipotermia, patah tulang, gigitan serangga/ular, navigasi darurat, dan manajemen logistik di gunung. | Pendaki |
| **SKPL-F-31** | Template Pertolongan Cepat (*Quick Prompts*) | Menyediakan rekomendasi pertanyaan cepat siap pakai untuk situasi kritis tanpa perlu mengetik panjang (misal: "Gejala Hipotermia Akut", "Pertolongan Keseleo", "Menemukan Air"). | Pendaki |

### 3.9 Modul 9: Sinkronisasi Offline-First & Realtime Cloud
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-32** | Antrean Sinkronisasi Lokal (*Sync Queue*) | Segala transaksi yang terjadi saat offline (pembuatan draf izin, log insiden, pembaruan data) disimpan di SQLite lokal dengan status `menunggu_sinkronisasi`. | Sistem |
| **SKPL-F-33** | Auto-Sync Latar Belakang | Begitu koneksi internet pulih (`connectivity_plus`), sistem otomatis mengirimkan payload antrean ke Supabase Cloud dan memperbarui status menjadi `tersinkronisasi`. | Sistem |

### 3.10 Modul 10: Gamifikasi & Evaluasi Pengguna
| Kode Kebutuhan | Nama Kebutuhan | Deskripsi & Spesifikasi Alur | Aktor |
| :--- | :--- | :--- | :--- |
| **SKPL-F-34** | Mini Game Mountain Climber | Pengguna dapat memainkan mini-game interaktif edukasi pendakian untuk mengisi waktu senggang saat berada di camp atau tenda. | Pendaki |
| **SKPL-F-35** | Feedback & Ulasan Aplikasi | Pengguna dapat mengirimkan kesan, pesan, dan rating bintang (1 - 5) terkait pengalaman penggunaan sistem TimurLang. | Pendaki |

---

# BAB 4: KEBUTUHAN NON-FUNGSIONAL SISTEM

Kebutuhan non-fungsional diberi kode **SKPL-NF-[NOMOR]**:

| Kode | Kategori | Kebutuhan & Parameter Kualitas |
| :---: | :--- | :--- |
| **SKPL-NF-01** | **Performance** | Waktu respon antarmuka aplikasi mobile pada transisi layar tidak melebihi 1,5 detik. Waktu deteksi dan pemindaian QR Code tiket tidak melebihi 1 detik pada pencahayaan cukup. |
| **SKPL-NF-02** | **Availability & Offline Support** | Fitur inti keselamatan (Peta Tersimpan, Kompas, Alarm Darurat SOS, Biodata Medis Lokal) harus memiliki ketersediaan 100% (*high availability*) meskipun perangkat berada di area *blank spot* tanpa sinyal seluler. |
| **SKPL-NF-03** | **Security & Integrity** | Kata sandi pengguna harus dienkripsi dengan algoritma *cryptographic hash* (SHA-256). Integritas tiket SIMAKSI diverifikasi dengan algoritma *block-hashing* dan tercatat pada buku besar publik blockchain Polygon. Akses basis data cloud dijamin melalui Supabase Row Level Security (RLS). |
| **SKPL-NF-04** | **Usability & UX** | Antarmuka pengguna mengadopsi standar modern Material 3 dengan kontras warna tinggi, tombol aksi darurat (SOS) berukuran besar dan mudah dijangkau dengan satu tangan saat kondisi panik/ekstrim. |
| **SKPL-NF-05** | **Reliability** | Algoritma Fall Detection wajib meminimalkan *false alarm* dengan menyediakan jeda pembatalan (*cancellation timer*) selama 15 detik disertai peringatan audio dan getaran intensif sebelum sinyal darurat dipancarkan. |
| **SKPL-NF-06** | **Compatibility** | Sistem dapat berjalan mulus pada platform sistem operasi Android versi 8.0 hingga versi terbaru, serta iOS versi 13 ke atas dengan konsumsi baterai optimal saat pelacakan GPS di latar belakang. |

---

# BAB 5: PANDUAN LENGKAP PEMETAAN PERANCANGAN DIAGRAM UML

Bab ini dirancang khusus untuk memandu pembuatan seluruh diagram UML pada laporan proyek.

### 5.1 Use Case Diagram (Matriks Aktor vs Use Case)
Diagram Use Case memetakan fungsionalitas sistem terhadap masing-masing aktor:

```
                            SISTEM TIMURLANG
+-------------------------------------------------------------------------+
|                                                                         |
|   (UC-01: Registrasi & Login Akun) <--------------------+               |
|   (UC-02: Otentikasi Biometrik) <-----------------------|               |
|   (UC-03: Kelola Profil & Rekam Medis) <----------------+               |
|   (UC-04: Eksplorasi Gunung & Cuaca) <------------------+               |
|   (UC-05: Ajukan Izin SIMAKSI) <------------------------|               |
|       |                                                 |               |
|       +-- <<include>> --> (UC-06: Bayar Tiket Midtrans)-|               |
|       +-- <<include>> --> (UC-07: Terbitkan Tiket Web3)-+               |
|                                                         |               |
|   (UC-08: Navigasi Peta & Kompas Offline) <-------------+   <<Aktor>>   |
|   (UC-09: Picu Darurat SOS & Fall Detection) <----------+    Pendaki    |
|   (UC-10: Konsultasi AI Survival Gemini) <--------------+               |
|   (UC-11: Main Mini Game & Beri Ulasan) <---------------+               |
|                                                                         |
|   (UC-12: Akses Dashboard Basecamp) <-------------------+               |
|   (UC-13: Scan & Verifikasi QR Tiket) <-----------------+   <<Aktor>>   |
|   (UC-14: Lakukan Check-In & Check-Out) <---------------+    Petugas    |
|   (UC-15: Pantau Pendaki Aktif di Jalur) <--------------+   Basecamp    |
|   (UC-16: Kelola Pos & Kuota Jalur) <-------------------+               |
|                                                                         |
|   (UC-06: Bayar Tiket Midtrans) ------------------------>  Midtrans     |
|   (UC-07: Terbitkan Tiket Web3) ------------------------>  Polygon Web3 |
|   (UC-09: Terima Sinyal SOS Realtime) ------------------>  Petugas      |
|   (UC-10: Proses Respon Cerdas) ------------------------>  Gemini AI    |
+-------------------------------------------------------------------------+
```

#### Tabel Pemetaan Use Case
| ID Use Case | Nama Use Case | Aktor Utama | Aktor Sekunder / Sistem | Relasi Khusus |
| :--- | :--- | :--- | :--- | :--- |
| **UC-01** | Registrasi & Login Akun | Pendaki, Petugas | Supabase Auth | - |
| **UC-02** | Otentikasi Biometrik | Pendaki, Petugas | Sensor Biometrik | `<<extend>>` ke UC-01 |
| **UC-03** | Kelola Profil & Data Medis | Pendaki | Local DB & Supabase | - |
| **UC-04** | Eksplorasi Gunung & Cuaca | Pendaki, Petugas | API Cuaca | - |
| **UC-05** | Pengajuan Izin SIMAKSI | Pendaki | Local DB, Supabase | `<<include>>` UC-06 & UC-07 |
| **UC-06** | Pembayaran Tiket Online | Pendaki | Midtrans Gateway | Bagian dari UC-05 |
| **UC-07** | Pencatatan Tiket Blockchain | Sistem | Polygon Web3 RPC | Bagian dari UC-05 |
| **UC-08** | Navigasi Peta & Kompas | Pendaki | Sensor GPS & Magneto | - |
| **UC-09** | Aktivasi SOS Darurat & Deteksi Jatuh | Pendaki, Sistem | Audio, Sensor, Supabase | - |
| **UC-10** | Konsultasi AI Survival | Pendaki | Google Gemini API | - |
| **UC-11** | Verifikasi Tiket QR Code | Petugas | Kamera, Scanner | - |
| **UC-12** | Monitoring Pendaki Aktif | Petugas | Supabase Realtime | - |
| **UC-13** | Check-in / Check-out Pendaki | Petugas | Supabase Database | - |

---

### 5.2 Spesifikasi Skenario Use Case Utama (Detailed Scenario)

#### A. Skenario Use Case: Pengajuan SIMAKSI & Pembayaran (UC-05 & UC-06)
- **Aktor Utama**: Pendaki
- **Kondisi Awal (*Pre-condition*)**: Pendaki telah login dan melengkapi data KTP serta profil medis.
- **Kondisi Akhir (*Post-condition*)**: Izin terdaftar, pembayaran lunas, E-Tiket terbit dengan QR Code dan blok hash tercatat di blockchain Polygon.
- **Alur Normal (*Main Flow*)**:
  1. Pendaki memilih menu SIMAKSI lalu menekan "Ajukan Izin Baru".
  2. Sistem menampilkan daftar gunung yang berstatus 'Buka' beserta sisa kuota.
  3. Pendaki memilih gunung, pos basecamp, tanggal naik, tanggal turun, dan jumlah anggota.
  4. Pendaki mengisi data identitas setiap anggota rombongan.
  5. Sistem menghitung rincian total tarif retribusi dan asuransi pendakian.
  6. Pendaki menekan tombol "Lanjut ke Pembayaran".
  7. Sistem membuka halaman Midtrans Snap Payment Gateway.
  8. Pendaki memilih metode pembayaran (misal: QRIS/Virtual Account) dan menyelesaikan pembayaran.
  9. Sistem menerima konfirmasi status *settlement* dari Midtrans.
  10. Sistem menghasilkan pasangan *block hash* kriptografis dan mengirimkan transaksi pencatatan ke Polygon Testnet.
  11. Sistem menerbitkan E-Tiket berstatus "Terbayar" yang dilengkapi QR Code unik.
- **Alur Alternatif (*Alternative Flow*)**:
  - *4a. Data Medis / KTP Belum Lengkap*: Sistem menampilkan pesan peringatan dan mengarahkan pendaki ke layar formulir identitas terlebih dahulu.
  - *8a. Pembayaran Kedaluwarsa / Batal*: Sistem mengubah status pengajuan menjadi "Dibatalkan" dan mengembalikan kuota harian.

#### B. Skenario Use Case: Pemicu Darurat SOS & Deteksi Jatuh (UC-09)
- **Aktor Utama**: Pendaki & Sensor Akselerometer Perangkat
- **Kondisi Awal**: Aplikasi TimurLang berjalan di perangkat pendaki di area pendakian.
- **Kondisi Akhir**: Sinyal bahaya, koordinat GPS, dan profil medis pendaki tersiar ke petugas basecamp dan alarm audio lokal berbunyi.
- **Alur Normal (Deteksi Jatuh Otomatis)**:
  1. Sensor akselerometer mendeteksi lonjakan gaya tumbukan ekstrim (*fall impact spike* > 25 m/s²) disusul keadaan hening tanpa orientasi gerak.
  2. Sistem memicu layar hitung mundur darurat selama 15 detik disertai getaran dan alarm peringatan pra-darurat.
  3. Jika pendaki tidak membatalkan hitungan mundur hingga detik ke-0:
  4. Sistem mengaktifkan sirene darurat audio pada volume maksimal secara berulang.
  5. Sistem mengambil koordinat latitude dan longitude terkini melalui GPS.
  6. Sistem membentuk paket payload insiden darurat (ID Pendaki, Koordinat, Golongan Darah, Riwayat Penyakit, Kontak Darurat).
  7. Sistem menyiarkan insiden ke server Supabase (tercatat di tabel `sos_incident_logs`).
  8. Dashboard Petugas Basecamp secara otomatis memunculkan pop-up audio visual insiden darurat pendaki dengan pin lokasi peta.
- **Alur Alternatif**:
  - *2a. False Alarm*: Pendaki menekan tombol "Saya Baik-Baik Saja / Batal" dalam kurun waktu 15 detik; sistem menghentikan pemicuan alarm dan tidak mengirim laporan darurat.

#### C. Skenario Use Case: Verifikasi Tiket QR & Check-In oleh Petugas (UC-11 & UC-13)
- **Aktor Utama**: Petugas Basecamp
- **Kondisi Awal**: Pendaki tiba di pos basecamp membawa E-Tiket di smartphone.
- **Kondisi Akhir**: Tiket tervalidasi dan status pendaki berubah menjadi aktif di jalur (*Check-In*).
- **Alur Normal**:
  1. Petugas membuka menu "Scan Tiket" pada aplikasi TimurLang mode Basecamp.
  2. Petugas mengarahkan kamera ke QR Code pada E-Tiket pendaki.
  3. Sistem memindai dan mendekripsi token data tiket.
  4. Sistem melakukan verifikasi silang ke basis data (mencocokkan tanggal izin, nama ketua, jumlah rombongan, dan hash tiket).
  5. Sistem menampilkan dialog ringkasan: "Tiket Valid - Lunas".
  6. Petugas memeriksa perlengkapan fisik rombongan, lalu menekan tombol "Konfirmasi Check-In".
  7. Sistem mengubah status izin menjadi 'Aktif' dan mencatat waktu mulai pendakian.
  8. Data rombongan otomatis muncul pada layar *Hiker Monitor* Petugas.

---

### 5.3 Class Diagram (Struktur Kelas Sistem)

Struktur kelas didesain mengikuti pola pemisahan lapisan: **Models**, **Services / Controllers**, dan **Presentation Screens**.

```
+-----------------------------------------------------------------------------------+
|                                  CLASS DIAGRAM                                    |
+-----------------------------------------------------------------------------------+

 +-------------------------+                +-------------------------+
 |          User           | 1            1 |      MedicalProfile     |
 +-------------------------+----------------+-------------------------+
 | - id: String            |                | - id: String            |
 | - peran: String         |                | - userId: String        |
 | - namaLengkap: String   |                | - golonganDarah: String |
 | - email: String         |                | - riwayatPenyakit: Str  |
 | - passwordHash: String  |                | - alergi: String        |
 | - fotoProfilUrl: String |                | - kontakDaruratNama: Str|
 | - isBiometric: bool     |                | - kontakDaruratTelp: Str|
 +-------------------------+                +-------------------------+
 | + toMap(): Map          |                | + toMap(): Map          |
 | + fromMap(map): User    |                | + fromMap(map): MedProf |
 +-------------------------+                +-------------------------+
             | 1
             |
             | 1
 +-------------------------+
 |    UserPersonalData     |
 +-------------------------+
 | - id: String            |
 | - userId: String        |
 | - jenisIdentitas: String|
 | - nomorKtp: String      |
 | - namaLengkap: String   |
 | - tanggalLahir: DateTime|
 | - jenisKelamin: String  |
 | - noTelepon: String     |
 | - noTeleponDarurat: Str |
 | - alamat: String        |
 +-------------------------+
 | + get namaGabungan():Str|
 +-------------------------+

             | 1
             |
             | *
 +-------------------------+ 1            * +-------------------------+
 |      SimaksiPermit      |--------------->|       MemberInfo        |
 +-------------------------+                +-------------------------+
 | - id: String            |                | - nama: String          |
 | - userId: String        |                | - alamat: String        |
 | - gunungId: String      |                | - kontakDarurat: String |
 | - basecampId: String    |                | - isKetua: bool         |
 | - tanggalNaik: DateTime |                | - noKtp: String         |
 | - tanggalTurun: DateTime|                | - noTelepon: String     |
 | - jumlahAnggota: int    |                +-------------------------+
 | - statusIzin: String    |                | + toMap(): Map          |
 | - blockHash: String     |                +-------------------------+
 | - previousHash: String  |
 | - totalBiaya: double    |
 +-------------------------+
 | + generateHash(): String|
 | + isPermitActive(): bool|
 +-------------------------+
             | *
             |
             | 1
 +-------------------------+ 1            * +-------------------------+
 |        Mountain         |<---------------+      BasecampPost       |
 +-------------------------+                +-------------------------+
 | - id: String            |                | - id: String            |
 | - namaGunung: String    |                | - gunungId: String      |
 | - elevasiMdpl: int      |                | - userIdPetugas: String |
 | - tingkatBahaya: String |                | - namaPos: String       |
 | - sumberAir: bool       |                | - lokasiDeskripsi: Str  |
 | - statusJalur: String   |                | - kontakPos: String     |
 | - koordinatLat: double  |                +-------------------------+
 | - koordinatLong: double |
 | - kuotaHarian: int      |
 +-------------------------+

             | 1
             |
             | *
 +-------------------------+                +-------------------------+
 |     SosIncidentLog      |                |        SyncQueue        |
 +-------------------------+                +-------------------------+
 | - id: String            |                | - id: String            |
 | - userId: String        |                | - namaTabel: String     |
 | - gunungId: String      |                | - recordId: String      |
 | - basecampId: String    |                | - aksiTipe: String      |
 | - koordinatLat: double  |                | - payloadJson: Map      |
 | - koordinatLong: double |                | - statusSync: String    |
 | - tipePemicu: String    |                | - syncedAt: DateTime    |
 | - statusPenanganan: Str |                +-------------------------+
 | - waktuKejadian: Date   |                | + markAsSynced(): void  |
 +-------------------------+                +-------------------------+
 | + toBroadcastJson(): Str|
 +-------------------------+

 =====================================================================
                        CORE SYSTEM SERVICES
 =====================================================================
 +-------------------------+    +-------------------------+
 |     DatabaseService     |    |     SupabaseService     |
 +-------------------------+    +-------------------------+
 | - db: Database          |    | - client: SupabaseClient|
 +-------------------------+    +-------------------------+
 | + insertUser()          |    | + streamSosIncidents()  |
 | + getPermits()          |    | + updatePermitStatus()  |
 | + saveOfflineIncident() |    | + pushSyncQueue()       |
 +-------------------------+    +-------------------------+

 +-------------------------+    +-------------------------+
 |    BlockchainService    |    |       SosManager        |
 +-------------------------+    +-------------------------+
 | - rpcClient: Web3Client |    | - sensorSvc: SensorSvc  |
 | - chainId: 80002        |    | - audioPlayer: Audio    |
 +-------------------------+    +-------------------------+
 | + broadcastPermitTicket |    | + triggerManualSos()    |
 | + verifyTicketOnChain() |    | + onFallDetected()      |
 +-------------------------+    | + cancelSosCountdown()  |
                                +-------------------------+
```

---

### 5.4 Activity Diagram (Alur Kerja Operasional Utama)

#### A. Activity Diagram: Pendaftaran & Pembayaran Izin SIMAKSI
1. **Pendaki**: Buka Halaman SIMAKSI -> Tekan "Ajukan SIMAKSI".
2. **Sistem**: Cek data identitas & data medis di SQLite.
3. **Decision**: Apakah data lengkap?
   - **Tidak**: Arahkan ke form pengisian KTP & Data Medis -> Simpan.
   - **Ya**: Tampilkan form pengajuan (Pilih Gunung, Tanggal, Anggota).
4. **Pendaki**: Mengisi form izin pendakian dan data anggota -> Tekan "Lanjut Pembayaran".
5. **Sistem**: Hitung total biaya -> Panggil Midtrans Snap Token via `MidtransService`.
6. **Sistem**: Buka WebView Pembayaran Midtrans.
7. **Pendaki**: Selesaikan transfer pembayaran (VA / QRIS).
8. **Midtrans Gateway**: Kirim callback status transaksi berhasil.
9. **Sistem**: Panggil `BlockchainService` -> Hitung block hash tiket -> Kirim transaksi verifikasi ke Polygon Testnet.
10. **Sistem**: Simpan tiket ke Local DB & Supabase -> Tampilkan E-Tiket ber-QR Code.

#### B. Activity Diagram: Deteksi Jatuh & Tanggap Darurat SOS
1. **Sensor Service**: Membaca streaming sensor akselerometer secara berkala.
2. **Decision**: Apakah terdeteksi lonjakan percepatan > threshold tumbukan jatuh?
   - **Tidak**: Lanjutkan membaca sensor.
   - **Ya**: Masuk ke *State Countdown* Darurat (15 detik).
3. **Sistem**: Memutar alarm getar & hitung mundur visual di layar.
4. **Decision**: Apakah tombol "Batalkan" ditekan oleh pendaki?
   - **Ya**: Hentikan hitungan mundur -> Kembali ke mode normal.
   - **Tidak (Waktu Habis)**: Masuk ke *State Darurat Aktif*.
5. **Sistem**: Ambil koordinat GPS terkini via `Geolocator`.
6. **Sistem**: Putar sirene audio darurat pada volume maksimal.
7. **Sistem**: Catat insiden ke `sos_incident_logs` di database lokal dan kirim payload ke Supabase Realtime Channel.
8. **Petugas Basecamp**: Menerima notifikasi darurat instan di Hiker Monitor Screen -> Siagakan Tim SAR Posko.

---

### 5.5 Sequence Diagram (Interaksi Komponen Sistem)

#### Sequence Diagram: Verifikasi Tiket & Check-in Pendaki di Pos Basecamp
```
Pendaki            Petugas         Basecamp UI      ScannerService     DatabaseService     SupabaseService
   |                  |                 |                  |                  |                   |
   |-- Tunjukkan QR ->|                 |                  |                  |                   |
   |                  |-- Buka Menu --->|                  |                  |                   |
   |                  |   Scan Tiket    |-- Inisialisasi ->|                  |                   |
   |                  |                 |   Kamera         |                  |                   |
   |                  |-- Arahkan ----->|-- Tangkap Frame->|                  |                   |
   |                  |   Kamera ke QR  |                  |-- Parse QR ----->|                   |
   |                  |                 |                  |   (Permit ID)    |                   |
   |                  |                 |<-- Return Token -|                  |                   |
   |                  |                 |                                     |                   |
   |                  |                 |-- getPermitById(permitId) --------->|                   |
   |                  |                 |<-- Return Permit Record ------------|                   |
   |                  |                 |                                     |                   |
   |                  |                 |-- Cek Status: 'Terbayar' & Hash OK  |                   |
   |                  |<-- Tampilkan ---|                                     |                   |
   |                  |    Data Valid   |                                     |                   |
   |                  |                 |                                     |                   |
   |                  |-- Klik Tombol ->|                                     |                   |
   |                  |   Check-In      |-- updateStatus('Check-In') -------->|                   |
   |                  |                 |-- updatePermitStatus(id, 'Aktif') --------------------->|
   |                  |                 |<-- Status Berhasil -------------------------------------|
   |                  |<-- Tampilkan ---|                                     |                   |
   |                  |    Sukses Masuk |                                     |                   |
```

---

### 5.6 State Machine Diagram (Siklus Hidup Tiket & Insiden)

#### A. State Machine: Siklus Status Izin SIMAKSI (`simaksi_permits`)
```
[*] --> [Draft / Diajukan] : Pendaki mengisi formulir
[Draft / Diajukan] --> [Menunggu Pembayaran] : Konfirmasi formulir izin
[Menunggu Pembayaran] --> [Terbayar] : Transaksi Midtrans Sukses & Block Hash Terbit
[Menunggu Pembayaran] --> [Dibatalkan / Expired] : Batas waktu pembayaran habis
[Terbayar] --> [Aktif (Check-In)] : Petugas scan QR di pos gerbang masuk
[Aktif (Check-In)] --> [Selesai (Check-Out)] : Petugas scan QR di pos gerbang turun
[Selesai (Check-Out)] --> [*]
```

#### B. State Machine: Siklus Insiden Darurat SOS (`sos_incident_logs`)
```
[*] --> [Siaga Normal] : Monitoring sensor
[Siaga Normal] --> [Peringatan Countdown (15s)] : Terdeteksi tumbukan jatuh / tombol SOS ditekan
[Peringatan Countdown (15s)] --> [Siaga Normal] : Dibatalkan manual oleh pendaki (False Alarm)
[Peringatan Countdown (15s)] --> [Darurat Aktif] : Waktu habis / Konfirmasi panik
[Darurat Aktif] --> [Dalam Penanganan SAR] : Petugas basecamp merespon panggilan
[Dalam Penanganan SAR] --> [Terevakuasi / Selesai] : Korban ditemukan & tertangani
[Terevakuasi / Selesai] --> [*]
```

---

### 5.7 Deployment Diagram (Arsitektur Fisik & Topologi Jaringan)

```
+-------------------------------------------------------------------------------+
|                             DEPLOYMENT DIAGRAM                                |
+-------------------------------------------------------------------------------+

  <<Perangkat Mobile Pendaki>>                     <<Perangkat Mobile Petugas>>
+-------------------------------+               +-------------------------------+
| Smartphone Android / iOS      |               | Smartphone Android / iOS      |
|                               |               |                               |
| +---------------------------+ |               | +---------------------------+ |
| | TimurLang App (Hiker)     | |               | | TimurLang App (Ranger)    | |
| |                           | |               | |                           | |
| | - Flutter UI Engine       | |               | | - Basecamp Dashboard UI   | |
| | - Sensor Svc (Acc/Compass)| |               | | - Mobile QR Scanner       | |
| | - Offline Map Engine      | |               | | - Hiker Monitor Module    | |
| | - Local DB (SQLite)       | |               | | - Local DB (SQLite)       | |
| +---------------------------+ |               +---------------------------+ |
+-------------------------------+               +-------------------------------+
                \                                              /
                 \ (HTTPS / WSS)                (HTTPS / WSS) /
                  \                                          /
                   v                                        v
  +---------------------------------------------------------------------------+
  |                          CLOUD INFRASTRUCTURE                             |
  |                                                                           |
  |  <<Supabase BaaS Cloud>>                                                  |
  |  +---------------------------------------------------------------------+  |
  |  | - PostgreSQL Database Engine (Tables, Constraints, Indexes)         |  |
  |  | - GoTrue Authentication Engine (JWT, User Sessions)                 |  |
  |  | - Realtime WebSockets (Live SOS Broadcast, Active Hiker Stream)     |  |
  |  | - Row Level Security (RLS Engine)                                   |  |
  |  +---------------------------------------------------------------------+  |
  |                                                                           |
  |  <<Midtrans Payment Engine>>              <<Blockchain Public Network>>   |
  |  +---------------------------+            +-----------------------------+ |
  |  | - Midtrans Snap Gateway   |            | - Polygon Amoy Testnet      | |
  |  | - Core API Notifications  |            | - RPC Endpoint: Port 80002  | |
  |  +---------------------------+            | - Smart Contract Ledger     | |
  |                                           +-----------------------------+ |
  |                                                                           |
  |  <<Google Cloud AI Platform>>             <<OpenWeather / BMKG>>          |
  |  +---------------------------+            +-----------------------------+ |
  |  | - Gemini Pro Generative AI|            | - Mountain Weather API      | |
  |  | - Survival Assistant API  |            | - REST Temperature/Wind     | |
  |  +---------------------------+            +-----------------------------+ |
  +---------------------------------------------------------------------------+
```

---

# BAB 6: SPESIFIKASI BASIS DATA (DATA DICTIONARY)

### 6.1 Tabel `users`
Menyimpan identitas akun pengguna utama.
| Nama Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | UUID / TEXT | PRIMARY KEY | Pengenal unik pengguna |
| `peran` | TEXT | NOT NULL | Nilai: `'pendaki'` atau `'basecamp'` |
| `nama_lengkap` | TEXT | NOT NULL | Nama akun pengguna |
| `email` | TEXT | UNIQUE, NOT NULL | Alamat email terdaftar |
| `password_hash`| TEXT | NOT NULL | Hash kata sandi (SHA-256) |
| `foto_profil_url`| TEXT | NULL | URL atau base64 foto profil |
| `is_biometric_enabled` | BOOLEAN | DEFAULT FALSE | Status aktivasi sensor biometrik |
| `gunung_id` | TEXT | NULL | Relasi ke gunung (khusus petugas) |
| `nama_basecamp`| TEXT | NULL | Nama pos yang dijaga petugas |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Waktu registrasi |

### 6.2 Tabel `user_personal_data`
Menyimpan data kartu identitas (KYC) syarat wajib izin SIMAKSI.
| Nama Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | TEXT | PRIMARY KEY | ID Data Personal |
| `user_id` | UUID / TEXT | NOT NULL, REFERENCES users(id) | Relasi pemilik data |
| `kewarganegaraan` | TEXT | NOT NULL | WNI atau WNA |
| `jenis_identitas` | TEXT | NOT NULL | KTP / Paspor / SIM / KITAS |
| `nomor_ktp` | TEXT | NOT NULL | Nomor unik tanda pengenal |
| `nama_lengkap` | TEXT | NOT NULL | Nama sesuai KTP |
| `tanggal_lahir`| DATE | NOT NULL | Tanggal lahir pendaki |
| `jenis_kelamin`| TEXT | NOT NULL | Laki-laki / Perempuan |
| `no_telepon` | TEXT | NOT NULL | Nomor kontak aktif |
| `no_telepon_darurat` | TEXT | NOT NULL | Nomor keluarga terdekat |
| `alamat` | TEXT | NOT NULL | Alamat jalan domisili |
| `provinsi` | TEXT | NOT NULL | Provinsi tempat tinggal |
| `kota_kabupaten`| TEXT | NOT NULL | Kabupaten / Kota |

### 6.3 Tabel `medical_profiles`
Menyimpan rekam medis kritis untuk penanganan darurat di pos SAR.
| Nama Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | UUID / TEXT | PRIMARY KEY | ID Profil Medis |
| `user_id` | UUID / TEXT | UNIQUE, REFERENCES users(id) | Relasi ke akun |
| `golongan_darah` | TEXT | NOT NULL | A, B, AB, atau O |
| `riwayat_penyakit`| TEXT | DEFAULT '' | Penyakit bawaan (asma, jantung) |
| `alergi` | TEXT | DEFAULT '' | Alergi obat/makanan/suhu |
| `kontak_darurat_nama`| TEXT | NOT NULL | Nama kerabat yang dihubungi |
| `kontak_darurat_telepon`| TEXT | NOT NULL | Nomor telepon kerabat |

### 6.4 Tabel `mountains`
Katalog gunung dan batas kuota konservasi.
| Nama Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | TEXT | PRIMARY KEY | Kode unik gunung (misal: 'mtn-011') |
| `nama_gunung` | TEXT | NOT NULL | Nama gunung (misal: 'Gunung Sumbing') |
| `elevasi_mdpl`| INTEGER | NOT NULL | Tinggi puncak gunung |
| `tingkat_bahaya`| TEXT | NOT NULL | Grade teknis (Grade 1 - Grade 3) |
| `sumber_air_tersedia`| BOOLEAN | NOT NULL | Ketersediaan mata air |
| `status_jalur` | TEXT | DEFAULT 'Buka' | Buka, Tutup, atau Waspada |
| `koordinat_lat`| DOUBLE | NOT NULL | Latitude titik basecamp/puncak |
| `koordinat_long`| DOUBLE | NOT NULL | Longitude titik basecamp/puncak |
| `kuota_harian` | INTEGER | NOT NULL | Kapasitas maksimal pendaki/hari |

### 6.5 Tabel `simaksi_permits`
Data perizinan, verifikasi pembayaran, dan pencatatan blockchain.
| Nama Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | TEXT | PRIMARY KEY | ID Unik Tiket (format UUID/Alfanumerik) |
| `user_id` | UUID / TEXT | REFERENCES users(id) | Ketua rombongan pemohon |
| `gunung_id` | TEXT | REFERENCES mountains(id) | Gunung tujuan |
| `basecamp_id`| TEXT | NULL | Pos jalur masuk yang dipilih |
| `tanggal_naik`| DATE | NOT NULL | Jadwal mulai mendaki |
| `tanggal_turun`| DATE | NOT NULL | Jadwal estimasi turun |
| `jumlah_anggota`| INTEGER | DEFAULT 1 | Total personil rombongan |
| `status_izin` | TEXT | DEFAULT 'Diajukan'| Diajukan, Terbayar, Aktif, Selesai |
| `block_hash` | TEXT | NOT NULL | SHA-256 hash izin tiket |
| `previous_hash`| TEXT | NOT NULL | Hash blok izin sebelumnya |
| `nonce` | INTEGER | DEFAULT 0 | Kriptografis nonce |
| `total_biaya` | DOUBLE | NOT NULL | Tagihan pembayaran (IDR) |

### 6.6 Tabel `sos_incident_logs`
Pencatatan insiden marabahaya dan pemantauan SAR.
| Nama Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | TEXT | PRIMARY KEY | ID Laporan Insiden |
| `user_id` | UUID / TEXT | REFERENCES users(id) | Korban pendaki |
| `gunung_id` | TEXT | REFERENCES mountains(id) | Lokasi gunung kejadian |
| `basecamp_id`| TEXT | NULL | Pos basecamp penanggung jawab |
| `koordinat_lat`| DOUBLE | NOT NULL | Titik latitude GPS saat SOS |
| `koordinat_long`| DOUBLE | NOT NULL | Titik longitude GPS saat SOS |
| `tipe_pemicu` | TEXT | NOT NULL | `'manual_sos'` atau `'fall_detection'` |
| `status_penanganan`| TEXT | DEFAULT 'darurat_aktif' | darurat_aktif, tertangani, selesai |
| `waktu_kejadian`| TIMESTAMPTZ | NOT NULL | Waktu tepat kejadian darurat |

---

# BAB 7: MATRIKS KETERLACAKAN KEBUTUHAN (TRACEABILITY MATRIX)

Matriks ini menghubungkan antara kebutuhan fungsional (SKPL-F) dengan artefak perancangan sistem (Use Case, Class, dan Screen):

| ID Kebutuhan | Nama Fitur | Use Case Terkait | Class Model / Service Terkait | Layar UI Aplikasi (Screens) |
| :--- | :--- | :--- | :--- | :--- |
| **SKPL-F-01** | Registrasi Akun | UC-01 | `User`, `AuthService` | `RegisterScreen` |
| **SKPL-F-02** | Login Akun | UC-01 | `User`, `AuthService` | `LoginScreen` |
| **SKPL-F-03** | Login Biometrik | UC-02 | `AuthService`, `local_auth` | `LoginScreen` |
| **SKPL-F-04** | Data Pribadi (KYC) | UC-03 | `UserPersonalData`, `DatabaseService` | `PersonalDataScreen` |
| **SKPL-F-05** | Profil Medis | UC-03 | `MedicalProfile`, `DatabaseService` | `MedicalProfileScreen` |
| **SKPL-F-06** | Logout | UC-01 | `AuthService` | `ProfileScreen` |
| **SKPL-F-07** | Katalog Gunung | UC-04 | `Mountain`, `DatabaseService` | `MountainListScreen`, `MountainDetailScreen` |
| **SKPL-F-08** | Monitoring Kuota | UC-04 | `Mountain`, `SupabaseService` | `MountainDetailScreen`, `HomeScreen` |
| **SKPL-F-09** | Cuaca Gunung | UC-04 | `WeatherService` | `WeatherScreen`, `HomeScreen` |
| **SKPL-F-10** | Pengajuan SIMAKSI | UC-05 | `SimaksiPermit`, `MemberInfo` | `SimaksiFormScreen` |
| **SKPL-F-11** | Validasi SIMAKSI | UC-05 | `SimaksiPermit`, `DatabaseService` | `SimaksiFormScreen` |
| **SKPL-F-12** | E-Tiket Digital | UC-05 | `SimaksiPermit`, `qr_flutter` | `SimaksiTicketScreen` |
| **SKPL-F-13** | Riwayat Perizinan | UC-05 | `SimaksiPermit`, `DatabaseService` | `HomeScreen`, `ProfileScreen` |
| **SKPL-F-14** | Pembayaran Midtrans| UC-06 | `MidtransService`, `webview_flutter` | `MidtransPaymentScreen`, `SimaksiPaymentScreen` |
| **SKPL-F-15** | Pencatatan Web3 | UC-07 | `BlockchainService`, `web3dart` | `SimaksiPaymentScreen`, `SimaksiTicketScreen` |
| **SKPL-F-16** | Cek PolygonScan | UC-07 | `BlockchainService`, `url_launcher` | `SimaksiTicketScreen` |
| **SKPL-F-17** | Peta Interaktif | UC-08 | `TrailService`, `flutter_map` | `MapScreen` |
| **SKPL-F-18** | Mode Peta Offline | UC-08 | `TrailService`, `DatabaseService` | `MapScreen` |
| **SKPL-F-19** | GPS Tracking | UC-08 | `geolocator` | `MapScreen` |
| **SKPL-F-20** | Kompas Digital | UC-08 | `SensorService`, `flutter_compass` | `CompassScreen` |
| **SKPL-F-21** | Tombol Darurat SOS | UC-09 | `SosManager`, `audioplayers` | `SosBeaconScreen` |
| **SKPL-F-22** | Deteksi Jatuh | UC-09 | `SensorService`, `sensors_plus` | `FallDetectionScreen` |
| **SKPL-F-23** | Siaran Darurat Cloud| UC-09 | `SosIncidentLog`, `SupabaseService` | `SosBeaconScreen`, `HikerMonitorScreen` |
| **SKPL-F-24** | Pesan Kontak Darurat| UC-09 | `url_launcher` | `SosBeaconScreen` |
| **SKPL-F-25** | Dashboard Basecamp | UC-12 | `BasecampPost`, `SupabaseService` | `BasecampDashboardScreen` |
| **SKPL-F-26** | Scan QR Tiket | UC-11 | `mobile_scanner`, `DatabaseService`| `TicketVerifyScreen` |
| **SKPL-F-27** | Check-in / Check-out| UC-13 | `SimaksiPermit`, `SupabaseService` | `TicketVerifyScreen`, `HikerMonitorScreen` |
| **SKPL-F-28** | Hiker Monitor Realtime| UC-12 | `SupabaseService` | `HikerMonitorScreen` |
| **SKPL-F-29** | Kelola Pos & Kuota | UC-14 | `BasecampPost`, `DatabaseService` | `ManageTrailCheckpointsScreen` |
| **SKPL-F-30** | AI Survival Chat | UC-10 | `GeminiService` | `SurvivalAssistantScreen` |
| **SKPL-F-31** | Quick Survival Prompt| UC-10 | `GeminiService` | `SurvivalAssistantScreen` |
| **SKPL-F-32** | Offline Sync Queue | - | `SyncQueue`, `DatabaseService` | `SyncService` |
| **SKPL-F-33** | Auto Cloud Sync | - | `SyncService`, `SupabaseService` | Background Service |
| **SKPL-F-34** | Mini-Game | - | `MountainClimberGame` | `MountainClimberScreen` |
| **SKPL-F-35** | Ulasan & Feedback | - | `CourseFeedback`, `DatabaseService`| `CourseFeedbackScreen` |

---
**-- AKHIR DOKUMEN SPESIFIKASI KEBUTUHAN PERANGKAT LUNAK (SKPL) TIMURLANG --**

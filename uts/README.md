# LokaTrip

LokaTrip adalah aplikasi mobile Flutter untuk menemukan inspirasi wisata lokal Indonesia. Aplikasi ini dibuat untuk memenuhi UTS Mobile Programming.

## Fitur

- Beranda dengan banner dan rekomendasi destinasi.
- Kategori destinasi: Alam, Pantai, Budaya, dan Kuliner.
- Halaman Eksplorasi dengan pencarian berdasarkan nama, lokasi, dan kategori.
- Halaman detail destinasi dengan deskripsi, rating, highlight, durasi, dan estimasi biaya.
- Navigasi tiga halaman menggunakan `NavigationBar`.
- Data dummy terstruktur dalam model `Destination` dan list `destinations`.
- Navigasi detail menggunakan `Navigator.push` dan `MaterialPageRoute`.

## Struktur Utama

```text
lib/
└── main.dart
    ├── Destination              # model data dummy
    ├── LokaTripApp               # root MaterialApp dan tema
    ├── MainShell                 # NavigationBar dan IndexedStack
    ├── HomePage                  # halaman beranda
    ├── ExplorePage               # pencarian dan daftar destinasi
    ├── SavedPage                 # halaman koleksi tersimpan
    ├── CategoryTile              # widget kategori
    ├── DestinationCard           # kartu destinasi
    └── DetailPage                # halaman detail
```

## Menjalankan Aplikasi

```bash
flutter pub get
flutter run
```

Untuk menjalankan versi web:

```bash
flutter run -d chrome
```

## Pengembangan Berikutnya

Data dummy dapat diganti dengan file JSON lokal atau REST API. Fitur bookmark pada halaman Tersimpan juga dapat dikembangkan menggunakan state management dan penyimpanan lokal.

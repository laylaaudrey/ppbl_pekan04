import 'package:flutter/foundation.dart';

class Berita {
  final int id;
  final String judul;
  final String kategori;
  final String tanggal;
  final String ringkasan;
  final String isi;
  final String ikon;

  const Berita({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.tanggal,
    required this.ringkasan,
    required this.isi,
    required this.ikon,
  });
}

class BeritaModel extends ChangeNotifier {
  final List<Berita> _berita = const [
    Berita(
      id: 1,
      judul: 'Pentingnya Mengetahui Jalur Evakuasi',
      kategori: 'Edukasi Bencana',
      tanggal: '19 Oktober 2026',
      ringkasan: 'Kenali jalur evakuasi dan titik kumpul sebelum keadaan darurat terjadi.',
      isi: 'Pastikan kamu mengetahui jalur evakuasi dari rumah, sekolah, atau tempat kerja. Pilih jalur yang tidak terhalang, sepakati titik kumpul keluarga, dan ikuti arahan petugas resmi. Informasi ini merupakan materi edukasi demonstrasi, bukan peringatan bencana terkini.',
      ikon: '🧭',
    ),
    Berita(
      id: 2,
      judul: 'Siapkan Tas Siaga Bencana',
      kategori: 'Kesiapsiagaan',
      tanggal: '18 Oktober 2026',
      ringkasan: 'Tas siaga membantu keluarga memenuhi kebutuhan dasar saat harus mengungsi.',
      isi: 'Isi tas siaga dengan air minum, makanan tahan lama, obat pribadi, senter, baterai, peluit, pakaian, salinan dokumen penting, dan perlengkapan kebersihan. Periksa isi tas secara berkala.',
      ikon: '🎒',
    ),
    Berita(
      id: 3,
      judul: 'Tetap Tenang dan Ikuti Informasi Resmi',
      kategori: 'Informasi Publik',
      tanggal: '17 Oktober 2026',
      ringkasan: 'Gunakan kanal resmi untuk memeriksa informasi dan instruksi kebencanaan.',
      isi: 'Jangan menyebarkan kabar yang belum terverifikasi. Periksa pengumuman dari BMKG, BNPB, BPBD, dan pemerintah setempat. Jika ada instruksi evakuasi resmi, ikuti arahan petugas.',
      ikon: '📢',
    ),
  ];

  List<Berita> get daftar => List.unmodifiable(_berita);

  Berita? berdasarkanId(int id) {
    for (final item in _berita) {
      if (item.id == id) return item;
    }
    return _berita.isEmpty ? null : _berita.first;
  }
}

import 'package:flutter/foundation.dart';

class Edukasi {
  final int id;
  final String judul;
  final String jenis;
  final String durasi;
  final String deskripsi;
  final String isi;
  final String ikon;

  const Edukasi({
    required this.id,
    required this.judul,
    required this.jenis,
    required this.durasi,
    required this.deskripsi,
    required this.isi,
    required this.ikon,
  });
}

class EdukasiModel extends ChangeNotifier {
  final List<Edukasi> _materi = const [
    Edukasi(
      id: 1,
      judul: 'Langkah Menghadapi Gempa Bumi',
      jenis: 'Artikel',
      durasi: '4 menit baca',
      deskripsi: 'Lindungi kepala, berlindung, dan menjauh dari benda yang berpotensi jatuh.',
      isi: 'Saat gempa terjadi di dalam ruangan, merunduk, berlindung di bawah meja yang kokoh, dan berpegangan. Lindungi kepala dan leher. Jauhi kaca serta lemari. Setelah guncangan berhenti, keluar dengan tertib melalui jalur aman jika memungkinkan dan ikuti instruksi petugas.',
      ikon: '📖',
    ),
    Edukasi(
      id: 2,
      judul: 'Kesiapsiagaan Tsunami',
      jenis: 'Video',
      durasi: '6 menit',
      deskripsi: 'Pelajari tanda bahaya dan pentingnya bergerak menuju tempat tinggi.',
      isi: 'Materi video demonstrasi: kenali peringatan resmi, jalur evakuasi tsunami, serta lokasi tinggi yang telah ditetapkan pemerintah. Jika merasakan gempa kuat atau lama di wilayah pesisir, segera menjauh dari pantai dan bergerak ke tempat tinggi tanpa menunggu melihat gelombang. Ikuti arahan resmi.',
      ikon: '▶️',
    ),
    Edukasi(
      id: 3,
      judul: 'Isi Tas Siaga Keluarga',
      jenis: 'Artikel',
      durasi: '3 menit baca',
      deskripsi: 'Daftar perlengkapan dasar yang perlu disiapkan oleh setiap keluarga.',
      isi: 'Siapkan air, makanan tahan lama, obat penting, senter, baterai, peluit, pakaian, masker, perlengkapan kebersihan, uang tunai secukupnya, dan salinan dokumen penting. Sesuaikan isi tas dengan kebutuhan bayi, lansia, dan anggota keluarga yang memerlukan bantuan khusus.',
      ikon: '🎒',
    ),
  ];

  List<Edukasi> get daftar => List.unmodifiable(_materi);

  Edukasi? berdasarkanId(int id) {
    for (final item in _materi) {
      if (item.id == id) return item;
    }
    return _materi.isEmpty ? null : _materi.first;
  }
}

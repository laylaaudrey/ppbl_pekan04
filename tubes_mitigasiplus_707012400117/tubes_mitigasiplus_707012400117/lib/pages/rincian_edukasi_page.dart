import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/edukasi_model.dart';

class RincianEdukasiPage extends StatelessWidget {
  final int edukasiId;
  const RincianEdukasiPage({super.key, required this.edukasiId});

  @override
  Widget build(BuildContext context) {
    final materi = context.watch<EdukasiModel>().berdasarkanId(edukasiId);
    return Scaffold(
      appBar: AppBar(title: const Text('Materi Mitigasi')),
      body: materi == null ? const Center(child: Text('Materi tidak ditemukan')) : ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: Text(materi.ikon, style: const TextStyle(fontSize: 64))),
          const SizedBox(height: 12),
          Text('${materi.jenis} • ${materi.durasi}', style: const TextStyle(color: Colors.blue)),
          const SizedBox(height: 10),
          Text(materi.judul, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(materi.deskripsi, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const Divider(height: 32),
          Text(materi.isi, style: const TextStyle(fontSize: 16, height: 1.7)),
          if (materi.jenis == 'Video') ...[
            const SizedBox(height: 20),
            const Card(child: Padding(
              padding: EdgeInsets.all(18),
              child: Row(children: [Icon(Icons.play_circle_outline, size: 40), SizedBox(width: 12), Expanded(child: Text('Tempat pemutar video demonstrasi. Hubungkan ke URL video edukasi resmi untuk menambahkan pemutaran video.'))]),
            )),
          ],
        ],
      ),
    );
  }
}

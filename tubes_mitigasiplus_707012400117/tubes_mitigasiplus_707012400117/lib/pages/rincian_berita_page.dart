import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/berita_model.dart';

class RincianBeritaPage extends StatelessWidget {
  final int beritaId;
  const RincianBeritaPage({super.key, required this.beritaId});

  @override
  Widget build(BuildContext context) {
    final berita = context.watch<BeritaModel>().berdasarkanId(beritaId);
    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Berita')),
      body: berita == null ? const Center(child: Text('Berita tidak ditemukan')) : ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: Text(berita.ikon, style: const TextStyle(fontSize: 60))),
          const SizedBox(height: 16),
          Text(berita.kategori, style: const TextStyle(color: Colors.blue)),
          const SizedBox(height: 8),
          Text(berita.judul, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(berita.tanggal, style: const TextStyle(color: Colors.grey)),
          const Divider(height: 30),
          Text(berita.isi, style: const TextStyle(fontSize: 16, height: 1.6)),
          const SizedBox(height: 20),
          const Text('Catatan: baca pengumuman dan peringatan bencana dari kanal resmi pemerintah.', style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

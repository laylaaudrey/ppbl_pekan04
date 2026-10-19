import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/edukasi_model.dart';
import '../navigation/app_routes.dart';
import 'beranda_page.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final materi = context.watch<EdukasiModel>().daftar;
    return Scaffold(
      appBar: AppBar(title: const Text('Mitigasi & Edukasi')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text('Pelajari langkah sederhana untuk mengurangi risiko bencana.', style: TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          ...materi.map((item) => GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.rincianEdukasi, arguments: item.id),
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 62, height: 72,
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Text(item.ikon, style: const TextStyle(fontSize: 30)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.jenis, style: const TextStyle(color: Colors.blue, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(item.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 5),
                        Text(item.deskripsi, maxLines: 3, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 5),
                        Text(item.durasi, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    )),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
      bottomNavigationBar: bottomBarMitigasiPlus(context, 2),
    );
  }
}

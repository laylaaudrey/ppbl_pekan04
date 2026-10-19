import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/berita_model.dart';
import '../navigation/app_routes.dart';
import 'beranda_page.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final daftar = context.watch<BeritaModel>().daftar;
    return Scaffold(
      appBar: AppBar(title: const Text('Berita Bencana')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftar.length,
        itemBuilder: (context, index) {
          final item = daftar[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.rincianBerita, arguments: item.id),
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 58, height: 58,
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Text(item.ikon, style: const TextStyle(fontSize: 30)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.kategori, style: const TextStyle(color: Colors.blue, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(item.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 5),
                        Text(item.ringkasan, maxLines: 3, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 6),
                        Text(item.tanggal, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: bottomBarMitigasiPlus(context, 1),
    );
  }
}

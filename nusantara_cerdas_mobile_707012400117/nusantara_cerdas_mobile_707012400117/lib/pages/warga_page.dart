import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nusantara Cerdas Mobile'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Selamat Datang, Warga!',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Layanan publik dalam satu aplikasi.'),
          const SizedBox(height: 20),

          _menu(
            context,
            'Tanya Petugas',
            Icons.chat,
            AppRoutes.tanyaPetugas,
          ),
          _menu(
            context,
            'Lokasi Kantor',
            Icons.map,
            AppRoutes.lokasiKantor,
          ),
          _menu(
            context,
            'Statistik Layanan',
            Icons.bar_chart,
            AppRoutes.statistikLayanan,
          ),

          const SizedBox(height: 20),
          const Text(
            'Riwayat Pengajuan',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (model.daftarPengajuan.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Belum ada pengajuan.'),
            ),

          ...List.generate(model.daftarPengajuan.length, (index) {
            final item = model.daftarPengajuan[index];

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(item.bidang),
                    content: Text(
                      'Nama: ${item.nama}\n'
                      'Email: ${item.email}\n'
                      'Sesi: ${item.sesi}\n'
                      'Status: ${item.selesai ? "Selesai" : "Diproses"}',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
              onLongPress: () {
                model.tandaiSelesai(index);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pengajuan ditandai selesai.'),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.description),
                  title: Text(item.bidang),
                  subtitle: Text(
                    '${item.nama} • ${item.sesi}',
                  ),
                  trailing: Icon(
                    item.selesai
                        ? Icons.check_circle
                        : Icons.pending_actions,
                    color: item.selesai
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.rincianLayanan,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _menu(
    BuildContext context,
    String judul,
    IconData ikon,
    String route,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(ikon, color: Colors.teal),
        title: Text(judul),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
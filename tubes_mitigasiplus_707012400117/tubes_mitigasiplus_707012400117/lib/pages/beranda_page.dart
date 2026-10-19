import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/berita_model.dart';
import '../model/edukasi_model.dart';
import '../model/sos_model.dart';
import '../navigation/app_routes.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final berita = context.watch<BeritaModel>().daftar;
    final edukasi = context.watch<EdukasiModel>().daftar;
    final jumlahSos = context.watch<SosModel>().jumlahLaporan;

    return Scaffold(
      appBar: AppBar(
        title: const Align(alignment: Alignment.centerLeft, child: Text('MitigasiPlus')),
        actions: [
          IconButton(
            tooltip: 'Profil',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profil),
            icon: const Icon(Icons.person),
          ),
          IconButton(
            tooltip: 'SOS / Darurat',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.sos),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Selamat Datang, Warga!', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 5),
          const Text('Apa yang ingin Anda lakukan hari ini?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 18),
          Card(
            color: const Color(0xFFE3F2FD),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.cloud_outlined, size: 42, color: Color(0xFF1976D2)),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cuaca di Kota Palu', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('27.9°C  •  Berawan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Data contoh, bukan prakiraan langsung'),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF1976D2), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                const Text('Akses Cepat Mitigasi Bencana', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.45,
                  children: [
                    _quick(context, Icons.emergency, 'SOS / Darurat', AppRoutes.sos),
                    _quick(context, Icons.article, 'Berita Bencana', AppRoutes.berita),
                    _quick(context, Icons.school, 'Edukasi Mitigasi', AppRoutes.edukasi),
                    _quick(context, Icons.location_on, 'Lokasi Aman', AppRoutes.lokasiAman),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.notifications_active)),
              title: const Text('Laporan SOS tersimpan'),
              subtitle: Text('$jumlahSos laporan dalam sesi aplikasi'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.sos),
            ),
          ),
          _section(context, 'Berita Bencana', AppRoutes.berita),
          ...berita.take(2).map((item) => Card(
            child: ListTile(
              leading: Text(item.ikon, style: const TextStyle(fontSize: 28)),
              title: Text(item.judul),
              subtitle: Text(item.ringkasan, maxLines: 2, overflow: TextOverflow.ellipsis),
              onTap: () => Navigator.pushNamed(context, AppRoutes.rincianBerita, arguments: item.id),
            ),
          )),
          _section(context, 'Edukasi Mitigasi', AppRoutes.edukasi),
          ...edukasi.take(2).map((item) => Card(
            child: ListTile(
              leading: Text(item.ikon, style: const TextStyle(fontSize: 28)),
              title: Text(item.judul),
              subtitle: Text('${item.jenis} • ${item.durasi}'),
              onTap: () => Navigator.pushNamed(context, AppRoutes.rincianEdukasi, arguments: item.id),
            ),
          )),
        ],
      ),
      bottomNavigationBar: bottomBarMitigasiPlus(context, 0),
      floatingActionButton: FloatingActionButton(
        tooltip: 'SOS Darurat',
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.sos),
        child: const Icon(Icons.emergency),
      ),
    );
  }

  Widget _quick(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF1976D2), size: 30),
            const SizedBox(height: 5),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF1976D2), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _section(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          TextButton(onPressed: () => Navigator.pushNamed(context, route), child: const Text('Lihat semua')),
        ],
      ),
    );
  }
}

Widget bottomBarMitigasiPlus(BuildContext context, int selected) {
  final routes = [AppRoutes.beranda, AppRoutes.berita, AppRoutes.edukasi, AppRoutes.lokasiAman, AppRoutes.profil];
  final labels = ['Beranda', 'Berita', 'Mitigasi', 'Lokasi Aman', 'Profil'];
  final icons = [Icons.home, Icons.article, Icons.school, Icons.location_on, Icons.person];
  return NavigationBar(
    selectedIndex: selected,
    onDestinationSelected: (index) {
      if (index != selected) Navigator.pushReplacementNamed(context, routes[index]);
    },
    destinations: List.generate(5, (i) => NavigationDestination(icon: Icon(icons[i]), label: labels[i])),
  );
}

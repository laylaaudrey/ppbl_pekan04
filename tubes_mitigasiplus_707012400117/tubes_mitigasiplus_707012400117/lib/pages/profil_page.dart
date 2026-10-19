import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/sos_model.dart';
import '../navigation/app_routes.dart';
import 'beranda_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jumlah = context.watch<SosModel>().jumlahLaporan;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 16),
          const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 48)),
          const SizedBox(height: 12),
          const Center(child: Text('Warga MitigasiPlus', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
          const Center(child: Text('Profil demonstrasi')),
          const SizedBox(height: 24),
          Card(child: ListTile(leading: const Icon(Icons.emergency), title: const Text('Jumlah laporan SOS'), trailing: Text('$jumlah'))),
          Card(child: ListTile(leading: const Icon(Icons.article), title: const Text('Berita Bencana'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.pushNamed(context, AppRoutes.berita))),
          Card(child: ListTile(leading: const Icon(Icons.school), title: const Text('Edukasi Mitigasi'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.pushNamed(context, AppRoutes.edukasi))),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('MitigasiPlus adalah prototipe pembelajaran. Pastikan informasi darurat berasal dari kanal resmi.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
      bottomNavigationBar: bottomBarMitigasiPlus(context, 4),
    );
  }
}

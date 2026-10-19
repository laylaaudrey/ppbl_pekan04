import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/lokasi_aman_model.dart';
import '../navigation/app_routes.dart';
import 'beranda_page.dart';

class LokasiAmanPage extends StatelessWidget {
  const LokasiAmanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LokasiAmanModel>();
    final lokasi = model.daftar;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Aman'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.sos),
            icon: const Icon(Icons.emergency, color: Colors.white),
            label: const Text('SOS', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: TextField(
              onChanged: model.cari,
              decoration: InputDecoration(
                hintText: 'Cari lokasi...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  tooltip: 'Hapus pencarian',
                  onPressed: () => model.cari(''),
                  icon: const Icon(Icons.close),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              children: [
                Expanded(child: _filter(context, model, 'Semua')),
                const SizedBox(width: 4),
                Expanded(child: _filter(context, model, 'Dalam Ruangan')),
                const SizedBox(width: 4),
                Expanded(child: _filter(context, model, 'Luar Ruangan')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Text('${lokasi.length} lokasi ditemukan'),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.petaLokasi),
                  icon: const Icon(Icons.map),
                  label: const Text('Lihat Peta'),
                ),
              ],
            ),
          ),
          Expanded(
            child: lokasi.isEmpty
                ? const Center(child: Text('Lokasi tidak ditemukan.'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    itemCount: lokasi.length,
                    itemBuilder: (context, index) {
                      final item = lokasi[index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.petaLokasi),
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 42, height: 42,
                                      decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(10)),
                                      child: const Icon(Icons.park, color: Colors.green),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(child: Text(item.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                    const Icon(Icons.verified_outlined, color: Colors.green),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(item.tipe, style: const TextStyle(color: Colors.blue)),
                                const SizedBox(height: 5),
                                Row(children: [const Icon(Icons.location_on, size: 17, color: Colors.grey), const SizedBox(width: 4), Expanded(child: Text(item.alamat))]),
                                const SizedBox(height: 8),
                                Text('${item.latitude}, ${item.longitude}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    TextButton.icon(onPressed: () => Navigator.pushNamed(context, AppRoutes.petaLokasi), icon: const Icon(Icons.directions, color: Colors.green), label: const Text('Navigasi')),
                                    const Spacer(),
                                    TextButton.icon(onPressed: () => Navigator.pushNamed(context, AppRoutes.petaLokasi), icon: const Icon(Icons.map), label: const Text('Lihat Maps')),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                                  child: Text(item.catatan, style: const TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: bottomBarMitigasiPlus(context, 3),
    );
  }

  Widget _filter(BuildContext context, LokasiAmanModel model, String value) {
    final aktif = model.filter == value;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        backgroundColor: aktif ? Colors.blue.shade50 : Colors.white,
        side: BorderSide(color: aktif ? Colors.blue : Colors.grey.shade300),
      ),
      onPressed: () => model.ubahFilter(value),
      child: Text(value == 'Dalam Ruangan' ? 'Dalam Ruangan' : value == 'Luar Ruangan' ? 'Luar Ruangan' : 'Semua',
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
    );
  }
}

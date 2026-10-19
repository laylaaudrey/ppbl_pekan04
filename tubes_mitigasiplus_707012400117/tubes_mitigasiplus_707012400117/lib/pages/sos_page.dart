import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/sos_model.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  final namaController = TextEditingController();
  final kontakController = TextEditingController();
  final deskripsiController = TextEditingController();
  String jenis = 'Gempa bumi';
  bool konfirmasi = false;
  bool loading = false;

  @override
  void dispose() {
    namaController.dispose();
    kontakController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  Future<void> kirim() async {
    if (namaController.text.trim().isEmpty ||
        kontakController.text.trim().isEmpty ||
        !konfirmasi ||
        loading) return;

    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    context.read<SosModel>().kirim(
      nama: namaController.text.trim(),
      kontak: kontakController.text.trim(),
      jenis: jenis,
      deskripsi: deskripsiController.text.trim(),
      butuhBantuan: true,
    );
    setState(() => loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Laporan tersimpan pada aplikasi (simulasi). Hubungi layanan darurat resmi jika membutuhkan pertolongan segera.')),
    );
    namaController.clear();
    kontakController.clear();
    deskripsiController.clear();
    setState(() => konfirmasi = false);
  }

  @override
  Widget build(BuildContext context) {
    final laporan = context.watch<SosModel>().daftar;
    final valid = namaController.text.trim().isNotEmpty &&
        kontakController.text.trim().isNotEmpty && konfirmasi;

    return Scaffold(
      appBar: AppBar(title: const Text('SOS / Darurat')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.red.shade200)),
            child: const Column(
              children: [
                Icon(Icons.emergency, color: Colors.red, size: 54),
                SizedBox(height: 8),
                Text('Formulir Laporan Darurat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Isi data untuk simulasi pencatatan laporan. Ini bukan layanan SOS langsung.', textAlign: TextAlign.center),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(controller: namaController, decoration: const InputDecoration(labelText: 'Nama lengkap', border: OutlineInputBorder()), onChanged: (_) => setState(() {})),
          const SizedBox(height: 12),
          TextField(controller: kontakController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Nomor kontak', border: OutlineInputBorder()), onChanged: (_) => setState(() {})),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: jenis,
            decoration: const InputDecoration(labelText: 'Jenis kejadian', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'Gempa bumi', child: Text('Gempa bumi')),
              DropdownMenuItem(value: 'Tsunami', child: Text('Tsunami')),
              DropdownMenuItem(value: 'Banjir', child: Text('Banjir')),
              DropdownMenuItem(value: 'Kebakaran', child: Text('Kebakaran')),
              DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
            ],
            onChanged: (value) { if (value != null) setState(() => jenis = value); },
          ),
          const SizedBox(height: 12),
          TextField(controller: deskripsiController, maxLines: 3, decoration: const InputDecoration(labelText: 'Keterangan kejadian (opsional)', border: OutlineInputBorder())),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: konfirmasi,
            onChanged: (value) => setState(() => konfirmasi = value ?? false),
            title: const Text('Saya memastikan informasi yang dimasukkan benar.'),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: valid && !loading ? kirim : null,
              icon: loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.send),
              label: Text(loading ? 'Mengirim...' : 'Kirim Laporan SOS'),
            ),
          ),
          const SizedBox(height: 22),
          Text('Riwayat laporan (${laporan.length})', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (laporan.isEmpty) const Padding(padding: EdgeInsets.all(12), child: Text('Belum ada laporan pada sesi ini.')),
          ...laporan.map((item) => Card(
            child: ListTile(
              leading: const Icon(Icons.warning_amber, color: Colors.orange),
              title: Text(item.jenis),
              subtitle: Text('${item.nama}\n${item.status}\n${item.waktu.toLocal()}'),
              isThreeLine: true,
            ),
          )),
        ],
      ),
    );
  }
}

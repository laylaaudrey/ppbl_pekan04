import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class RincianLayananPage extends StatefulWidget {
  const RincianLayananPage({super.key});

  @override
  State<RincianLayananPage> createState() =>
      _RincianLayananPageState();
}

class _RincianLayananPageState
    extends State<RincianLayananPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();

  bool setuju = false;
  String sesi = 'Pagi';
  String bidang = 'Administrasi';
  bool loading = false;

  bool get valid {
    return namaController.text.trim().isNotEmpty &&
        emailController.text.trim().contains('@') &&
        emailController.text.trim().isNotEmpty &&
        setuju;
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> kirimPengajuan() async {
    if (!valid || loading) return;

    setState(() => loading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context.read<PengajuanModel>().tambahPengajuan(
      Pengajuan(
        nama: namaController.text.trim(),
        email: emailController.text.trim(),
        sesi: sesi,
        bidang: bidang,
      ),
    );

    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengajuan berhasil dikirim!'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Formulir Pengajuan Layanan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: namaController,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: const OutlineInputBorder(),
              errorText: emailController.text.isNotEmpty &&
                      !emailController.text.contains('@')
                  ? 'Email harus mengandung @'
                  : null,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: bidang,
            decoration: const InputDecoration(
              labelText: 'Bidang Layanan',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Administrasi',
                child: Text('Administrasi'),
              ),
              DropdownMenuItem(
                value: 'Kependudukan',
                child: Text('Kependudukan'),
              ),
              DropdownMenuItem(
                value: 'Infrastruktur',
                child: Text('Infrastruktur'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => bidang = value);
              }
            },
          ),
          const SizedBox(height: 16),

          const Text(
            'Pilih Sesi Kunjungan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          ...['Pagi', 'Siang', 'Sore'].map(
            (pilihan) => RadioListTile<String>(
              title: Text(pilihan),
              value: pilihan,
              groupValue: sesi,
              onChanged: (value) {
                if (value != null) {
                  setState(() => sesi = value);
                }
              },
            ),
          ),

          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Saya menyetujui penggunaan data pribadi '
              'untuk keperluan layanan.',
            ),
            value: setuju,
            onChanged: (value) {
              setState(() => setuju = value ?? false);
            },
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: valid && !loading
                ? kirimPengajuan
                : null,
            child: loading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text('Mengirim...'),
                    ],
                  )
                : const Text('Kirim Pengajuan'),
          ),
        ],
      ),
    );
  }
}
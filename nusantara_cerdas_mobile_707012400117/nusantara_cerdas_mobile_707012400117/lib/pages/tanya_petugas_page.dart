import 'package:flutter/material.dart';

class TanyaPetugasPage extends StatefulWidget {
  const TanyaPetugasPage({super.key});

  @override
  State<TanyaPetugasPage> createState() =>
      _TanyaPetugasPageState();
}

class _TanyaPetugasPageState extends State<TanyaPetugasPage> {
  final controller = TextEditingController();

  final List<Map<String, dynamic>> pesan = [
    {
      'isi': 'Selamat datang! Ada yang bisa kami bantu?',
      'warga': false,
    },
  ];

  void kirimPesan() {
    final teks = controller.text.trim();
    if (teks.isEmpty) return;

    setState(() {
      pesan.add({'isi': teks, 'warga': true});
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tanya Petugas')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: pesan.length,
              itemBuilder: (context, index) {
                final item = pesan[index];
                final warga = item['warga'] as bool;

                return Align(
                  alignment: warga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                    ),
                    decoration: BoxDecoration(
                      color: warga
                          ? Colors.teal.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(item['isi'] as String),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Tulis pesan...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => kirimPesan(),
                    ),
                  ),
                  IconButton(
                    onPressed: kirimPesan,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
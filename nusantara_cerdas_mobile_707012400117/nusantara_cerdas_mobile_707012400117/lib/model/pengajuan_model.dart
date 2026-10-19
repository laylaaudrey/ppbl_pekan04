import 'package:flutter/material.dart';

class Pengajuan {
  final String nama;
  final String email;
  final String sesi;
  final String bidang;
  bool selesai;

  Pengajuan({
    required this.nama,
    required this.email,
    required this.sesi,
    required this.bidang,
    this.selesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftarPengajuan = [];

  List<Pengajuan> get daftarPengajuan =>
      List.unmodifiable(_daftarPengajuan);

  void tambahPengajuan(Pengajuan pengajuan) {
    _daftarPengajuan.add(pengajuan);
    notifyListeners();
  }

  void tandaiSelesai(int index) {
    if (index >= 0 && index < _daftarPengajuan.length) {
      _daftarPengajuan[index].selesai = true;
      notifyListeners();
    }
  }

  Map<String, int> get statistik {
    final Map<String, int> hasil = {};

    for (final pengajuan in _daftarPengajuan) {
      hasil[pengajuan.bidang] =
          (hasil[pengajuan.bidang] ?? 0) + 1;
    }

    return hasil;
  }
}
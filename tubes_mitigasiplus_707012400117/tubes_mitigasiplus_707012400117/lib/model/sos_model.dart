import 'package:flutter/foundation.dart';

class LaporanSOS {
  final String nama;
  final String kontak;
  final String jenis;
  final String deskripsi;
  final DateTime waktu;
  final bool butuhBantuan;
  String status;

  LaporanSOS({
    required this.nama,
    required this.kontak,
    required this.jenis,
    required this.deskripsi,
    required this.waktu,
    required this.butuhBantuan,
    this.status = 'Terkirim (simulasi)',
  });
}

class SosModel extends ChangeNotifier {
  final List<LaporanSOS> _laporan = [];

  List<LaporanSOS> get daftar => List.unmodifiable(_laporan);
  int get jumlahLaporan => _laporan.length;

  void kirim({
    required String nama,
    required String kontak,
    required String jenis,
    required String deskripsi,
    required bool butuhBantuan,
  }) {
    _laporan.insert(
      0,
      LaporanSOS(
        nama: nama,
        kontak: kontak,
        jenis: jenis,
        deskripsi: deskripsi,
        waktu: DateTime.now(),
        butuhBantuan: butuhBantuan,
      ),
    );
    notifyListeners();
  }

  void ubahStatus(int index, String status) {
    if (index >= 0 && index < _laporan.length) {
      _laporan[index].status = status;
      notifyListeners();
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiAman {
  final int id;
  final String nama;
  final String alamat;
  final String tipe;
  final double latitude;
  final double longitude;
  final String catatan;

  const LokasiAman({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.tipe,
    required this.latitude,
    required this.longitude,
    required this.catatan,
  });

  LatLng get koordinat => LatLng(latitude, longitude);
}

class LokasiAmanModel extends ChangeNotifier {
  final List<LokasiAman> _lokasi = const [
    LokasiAman(
      id: 1,
      nama: 'Halaman Kantor Gubernur Sulteng',
      alamat: 'Jl. Sam Ratulangi, Palu',
      tipe: 'Luar Ruangan',
      latitude: -0.898000,
      longitude: 119.872000,
      catatan: 'Contoh lokasi lapang; verifikasi status aman kepada BPBD.',
    ),
    LokasiAman(
      id: 2,
      nama: 'Lapangan Vatulemo',
      alamat: 'Jl. Moh. Hatta, Palu',
      tipe: 'Luar Ruangan',
      latitude: -0.900600,
      longitude: 119.870500,
      catatan: 'Contoh titik kumpul; ikuti arahan petugas setempat.',
    ),
    LokasiAman(
      id: 3,
      nama: 'Gedung Layanan Masyarakat',
      alamat: 'Palu, Sulawesi Tengah',
      tipe: 'Dalam Ruangan',
      latitude: -0.891500,
      longitude: 119.870000,
      catatan: 'Contoh gedung layanan; pastikan kelayakan bangunan.',
    ),
  ];

  String _kataKunci = '';
  String _filter = 'Semua';

  List<LokasiAman> get daftar {
    return _lokasi.where((lokasi) {
      final cocokNama = lokasi.nama.toLowerCase().contains(_kataKunci.toLowerCase()) ||
          lokasi.alamat.toLowerCase().contains(_kataKunci.toLowerCase());
      final cocokFilter = _filter == 'Semua' || lokasi.tipe == _filter;
      return cocokNama && cocokFilter;
    }).toList();
  }

  String get kataKunci => _kataKunci;
  String get filter => _filter;

  void cari(String value) {
    _kataKunci = value;
    notifyListeners();
  }

  void ubahFilter(String value) {
    _filter = value;
    notifyListeners();
  }

  Set<Marker> get markers => daftar.map((lokasi) {
    return Marker(
      markerId: MarkerId('lokasi_${lokasi.id}'),
      position: lokasi.koordinat,
      infoWindow: InfoWindow(title: lokasi.nama, snippet: lokasi.alamat),
    );
  }).toSet();
}

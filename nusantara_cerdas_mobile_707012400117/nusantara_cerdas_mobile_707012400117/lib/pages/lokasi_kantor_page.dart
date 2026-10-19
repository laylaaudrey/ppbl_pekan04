import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiKantorPage extends StatelessWidget {
  const LokasiKantorPage({super.key});

  static const LatLng pusatPeta = LatLng(
    -6.914744,
    107.609810,
  );

  static final Set<Marker> penanda = {
    const Marker(
      markerId: MarkerId('kantor1'),
      position: LatLng(-6.914744, 107.609810),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Pusat',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor2'),
      position: LatLng(-6.917464, 107.619123),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Timur',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor3'),
      position: LatLng(-6.902500, 107.600000),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Utara',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Kantor')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: pusatPeta,
          zoom: 13,
        ),
        markers: penanda,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: true,
      ),
    );
  }
}
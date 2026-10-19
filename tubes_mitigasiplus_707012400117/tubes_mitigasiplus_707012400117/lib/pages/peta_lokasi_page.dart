import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../model/lokasi_aman_model.dart';

class PetaLokasiPage extends StatelessWidget {
  const PetaLokasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LokasiAmanModel>();
    const palu = LatLng(-0.898000, 119.872000);

    return Scaffold(
      appBar: AppBar(title: const Text('Peta Lokasi Aman')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Penanda pada peta adalah contoh lokasi. Verifikasi keamanan dan akses dengan BPBD setempat.',
              style: TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(target: palu, zoom: 13),
              markers: model.markers,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}

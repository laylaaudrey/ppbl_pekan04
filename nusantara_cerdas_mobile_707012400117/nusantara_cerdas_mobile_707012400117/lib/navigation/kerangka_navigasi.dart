import 'package:flutter/material.dart';

import '../pages/warga_page.dart';
import '../pages/rincian_layanan_page.dart';
import '../pages/tanya_petugas_page.dart';
import '../pages/lokasi_kantor_page.dart';
import '../pages/statistik_layanan_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.warga:
        return MaterialPageRoute(
          builder: (_) => const WargaPage(),
          settings: settings,
        );

      case AppRoutes.rincianLayanan:
        return MaterialPageRoute(
          builder: (_) => const RincianLayananPage(),
          settings: settings,
        );

      case AppRoutes.tanyaPetugas:
        return MaterialPageRoute(
          builder: (_) => const TanyaPetugasPage(),
          settings: settings,
        );

      case AppRoutes.lokasiKantor:
        return MaterialPageRoute(
          builder: (_) => const LokasiKantorPage(),
          settings: settings,
        );

      case AppRoutes.statistikLayanan:
        return MaterialPageRoute(
          builder: (_) => const StatistikLayananPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const WargaPage(),
        );
    }
  }
}
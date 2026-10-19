import 'package:flutter/material.dart';

import '../pages/beranda_page.dart';
import '../pages/berita_page.dart';
import '../pages/rincian_berita_page.dart';
import '../pages/edukasi_page.dart';
import '../pages/rincian_edukasi_page.dart';
import '../pages/lokasi_aman_page.dart';
import '../pages/peta_lokasi_page.dart';
import '../pages/sos_page.dart';
import '../pages/profil_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case AppRoutes.beranda:
        page = const BerandaPage();
        break;
      case AppRoutes.berita:
        page = const BeritaPage();
        break;
      case AppRoutes.rincianBerita:
        page = RincianBeritaPage(beritaId: settings.arguments as int? ?? 0);
        break;
      case AppRoutes.edukasi:
        page = const EdukasiPage();
        break;
      case AppRoutes.rincianEdukasi:
        page = RincianEdukasiPage(edukasiId: settings.arguments as int? ?? 0);
        break;
      case AppRoutes.lokasiAman:
        page = const LokasiAmanPage();
        break;
      case AppRoutes.petaLokasi:
        page = const PetaLokasiPage();
        break;
      case AppRoutes.sos:
        page = const SosPage();
        break;
      case AppRoutes.profil:
        page = const ProfilPage();
        break;
      default:
        page = const BerandaPage();
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}

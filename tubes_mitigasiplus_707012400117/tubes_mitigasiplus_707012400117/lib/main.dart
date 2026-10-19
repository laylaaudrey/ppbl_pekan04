import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/berita_model.dart';
import 'model/edukasi_model.dart';
import 'model/lokasi_aman_model.dart';
import 'model/sos_model.dart';
import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BeritaModel()),
        ChangeNotifierProvider(create: (_) => EdukasiModel()),
        ChangeNotifierProvider(create: (_) => LokasiAmanModel()),
        ChangeNotifierProvider(create: (_) => SosModel()),
      ],
      child: const MitigasiPlusApp(),
    ),
  );
}

class MitigasiPlusApp extends StatelessWidget {
  const MitigasiPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MitigasiPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1976D2),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      initialRoute: AppRoutes.beranda,
      onGenerateRoute: KerangkaNavigasi.generateRoute,
    );
  }
}

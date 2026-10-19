import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../model/pengajuan_model.dart';

class StatistikLayananPage extends StatelessWidget {
  const StatistikLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statistik = context.watch<PengajuanModel>().statistik;

    final data = {
      'Administrasi': statistik['Administrasi'] ?? 0,
      'Kependudukan': statistik['Kependudukan'] ?? 0,
      'Infrastruktur': statistik['Infrastruktur'] ?? 0,
    };

    final nilaiTertinggi = data.values.fold<int>(
      0,
      (terbesar, nilai) => nilai > terbesar ? nilai : terbesar,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Layanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jumlah Pengajuan per Bidang',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: (nilaiTertinggi + 2).toDouble(),
                  minY: 0,
                  alignment: BarChartAlignment.spaceAround,
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= data.length) {
                            return const SizedBox.shrink();
                          }

                          final nama = data.keys.elementAt(index);

                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              nama,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  barGroups: List.generate(data.length, (index) {
                    final jumlah = data.values.elementAt(index);

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: jumlah.toDouble(),
                          width: 28,
                          color: Colors.teal,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 16),
            ...data.entries.map(
              (item) => ListTile(
                dense: true,
                title: Text(item.key),
                trailing: Text(
                  '${item.value} pengajuan',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
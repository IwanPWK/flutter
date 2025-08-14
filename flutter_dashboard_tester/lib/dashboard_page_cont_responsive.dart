import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardFullResponsivePage extends StatelessWidget {
  // ===== DATA DUMMY (ganti ke API nanti) =====
  final double omzetHariIni = 12500000;
  final double labaKotor = 4500000;
  final int totalTransaksi = 52;
  final String produkTerlaris = "Kopi Arabica";
  final double saldoKas = 8700000;
  final double totalPiutang = 2500000;

  final List<FlSpot> omzetData = const [
    FlSpot(1, 10),
    FlSpot(2, 12),
    FlSpot(3, 8),
    FlSpot(4, 15),
    FlSpot(5, 14),
    FlSpot(6, 20),
    FlSpot(7, 18),
  ];

  final List<PieChartSectionData> kategoriData = [
    PieChartSectionData(
      value: 40,
      title: 'Kopi',
      color: Colors.brown,
      radius: 50,
    ),
    PieChartSectionData(
      value: 30,
      title: 'Snack',
      color: Colors.orange,
      radius: 50,
    ),
    PieChartSectionData(
      value: 20,
      title: 'Minuman',
      color: Colors.blue,
      radius: 50,
    ),
    PieChartSectionData(
      value: 10,
      title: 'Lainnya',
      color: Colors.green,
      radius: 50,
    ),
  ];

  final List<BarChartGroupData> omzetBulananData = [
    BarChartGroupData(
      x: 1,
      barRods: [BarChartRodData(toY: 12, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [BarChartRodData(toY: 14, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [BarChartRodData(toY: 9, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [BarChartRodData(toY: 15, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [BarChartRodData(toY: 20, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 6,
      barRods: [BarChartRodData(toY: 18, color: Colors.blue)],
    ),
  ];

  final List<String> notifikasi = const [
    "⚠️ Stok Kopi Robusta tinggal 5 pcs",
    "✅ Target penjualan hari ini tercapai",
    "💰 Piutang pelanggan: Rp 2.500.000",
  ];

  DashboardFullResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard POS – Responsive")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          // Breakpoints
          final bool isPhone = width < 600;
          final bool isTablet = width >= 600 && width < 1024;
          final bool isDesktop = width >= 1024;

          final int gridCols = isPhone ? 2 : (isTablet ? 3 : 6);
          final double chartHeight = isPhone ? 220 : (isTablet ? 260 : 300);
          final double gridAspect =
              isPhone
                  ? 2.0
                  : (isTablet
                      ? 2.3
                      : 2.6); // kartu makin melebar di layar besar
          final EdgeInsets pagePadding = EdgeInsets.symmetric(
            horizontal: isDesktop ? 24 : 12,
            vertical: 12,
          );

          return SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== Ringkasan Angka =====
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: gridCols,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: gridAspect,
                  children: [
                    _SummaryCard(
                      "Omzet Hari Ini",
                      _formatRupiah(omzetHariIni),
                      Colors.blue,
                    ),
                    _SummaryCard(
                      "Laba Kotor",
                      _formatRupiah(labaKotor),
                      Colors.green,
                    ),
                    _SummaryCard(
                      "Transaksi",
                      "$totalTransaksi trx",
                      Colors.orange,
                    ),
                    _SummaryCard(
                      "Produk Terlaris",
                      produkTerlaris,
                      Colors.purple,
                    ),
                    _SummaryCard(
                      "Saldo Kas",
                      _formatRupiah(saldoKas),
                      Colors.teal,
                    ),
                    _SummaryCard(
                      "Piutang",
                      _formatRupiah(totalPiutang),
                      Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ===== Tren Omzet =====
                _SectionTitle("Tren Omzet (7 Hari Terakhir)"),
                const SizedBox(height: 12),
                SizedBox(
                  height: chartHeight,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 24,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: omzetData,
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          dotData: FlDotData(
                            show: !isPhone,
                          ), // titik disembunyikan di HP
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ===== Grid 2 kolom adaptif untuk Pie & Bar Chart =====
                _AdaptiveTwoCol(
                  isPhone: isPhone,
                  spacing: 12,
                  children: [
                    // Pie Chart
                    _CardBlock(
                      title: "Penjualan per Kategori",
                      child: SizedBox(
                        height: chartHeight,
                        child: PieChart(
                          PieChartData(
                            sections: kategoriData,
                            sectionsSpace: 4,
                            centerSpaceRadius: isPhone ? 24 : 40,
                          ),
                        ),
                      ),
                    ),
                    // Bar Chart
                    _CardBlock(
                      title: "Perbandingan Omzet Bulanan",
                      child: SizedBox(
                        height: chartHeight,
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 24,
                                  getTitlesWidget: (value, meta) {
                                    // Label bulan sederhana: 1..6 -> Jan..Jun (contoh)
                                    const labels = [
                                      'Jan',
                                      'Feb',
                                      'Mar',
                                      'Apr',
                                      'Mei',
                                      'Jun',
                                    ];
                                    final idx = value.toInt() - 1;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        (idx >= 0 && idx < labels.length)
                                            ? labels[idx]
                                            : '',
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: false),
                            barGroups: omzetBulananData,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ===== Notifikasi =====
                _SectionTitle("Notifikasi"),
                const SizedBox(height: 12),
                Column(
                  children:
                      notifikasi.map((msg) => _NotificationTile(msg)).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===== Utils =====
  String _formatRupiah(double value) {
    return "Rp ${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}";
  }
}

// ====== Widgets Kecil ======
class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const _SummaryCard(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _CardBlock extends StatelessWidget {
  final String title;
  final Widget child;
  const _CardBlock({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _AdaptiveTwoCol extends StatelessWidget {
  final bool isPhone;
  final double spacing;
  final List<Widget> children;
  const _AdaptiveTwoCol({
    required this.isPhone,
    required this.children,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (isPhone) {
      // Stack vertikal di HP
      return Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1) SizedBox(height: spacing),
          ],
        ],
      );
    }
    // Grid 2 kolom untuk tablet/desktop
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: 1.6,
      children: children,
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String message;
  const _NotificationTile(this.message);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.info, color: Colors.blue),
        title: Text(message),
      ),
    );
  }
}

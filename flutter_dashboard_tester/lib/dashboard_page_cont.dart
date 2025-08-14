import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPageCont extends StatelessWidget {
  // ===== DATA DUMMY (ganti ke API nanti) =====
  final double omzetHariIni = 12500000;
  final double labaKotor = 4500000;
  final int totalTransaksi = 52;
  final String produkTerlaris = "Kopi Arabica";
  final double saldoKas = 8700000;
  final double totalPiutang = 2500000;

  final List<FlSpot> omzetData = [
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

  final List<String> notifikasi = [
    "⚠️ Stok Kopi Robusta tinggal 5 pcs",
    "✅ Target penjualan hari ini tercapai",
    "💰 Piutang pelanggan: Rp 2.500.000",
  ];

  DashboardPageCont({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard POS - Full")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Ringkasan Angka =====
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              children: [
                _buildSummaryCard(
                  "Omzet Hari Ini",
                  _formatRupiah(omzetHariIni),
                  Colors.blue,
                ),
                _buildSummaryCard(
                  "Laba Kotor",
                  _formatRupiah(labaKotor),
                  Colors.green,
                ),
                _buildSummaryCard(
                  "Transaksi",
                  "$totalTransaksi trx",
                  Colors.orange,
                ),
                _buildSummaryCard(
                  "Produk Terlaris",
                  produkTerlaris,
                  Colors.purple,
                ),
                _buildSummaryCard(
                  "Saldo Kas",
                  _formatRupiah(saldoKas),
                  Colors.teal,
                ),
                _buildSummaryCard(
                  "Piutang",
                  _formatRupiah(totalPiutang),
                  Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ===== Grafik Tren =====
            const Text(
              "Tren Omzet (7 Hari Terakhir)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: omzetData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== Pie Chart =====
            const Text(
              "Penjualan per Kategori",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: kategoriData,
                  sectionsSpace: 4,
                  centerSpaceRadius: 30,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== Bar Chart =====
            const Text(
              "Perbandingan Omzet Bulanan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: true),
                  gridData: FlGridData(show: false),
                  barGroups: omzetBulananData,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== Notifikasi =====
            const Text(
              "Notifikasi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children:
                  notifikasi.map((msg) => _buildNotificationTile(msg)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
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

  Widget _buildNotificationTile(String message) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.info, color: Colors.blue),
        title: Text(message),
      ),
    );
  }

  String _formatRupiah(double value) {
    return "Rp ${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}";
  }
}

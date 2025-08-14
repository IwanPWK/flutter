import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  final double omzetHariIni = 12500000;
  final double labaKotor = 4500000;
  final int totalTransaksi = 52;
  final String produkTerlaris = "Kopi Arabica";

  final List<FlSpot> omzetData = [
    FlSpot(1, 10),
    FlSpot(2, 12),
    FlSpot(3, 8),
    FlSpot(4, 15),
    FlSpot(5, 14),
    FlSpot(6, 20),
    FlSpot(7, 18),
  ];

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard POS")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Ringkasan =====
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

            // ===== Notifikasi =====
            const Text(
              "Notifikasi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildNotificationTile("⚠️ Stok Kopi Robusta tinggal 5 pcs"),
            _buildNotificationTile("✅ Target penjualan hari ini tercapai"),
            _buildNotificationTile("💰 Piutang pelanggan: Rp 2.500.000"),
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

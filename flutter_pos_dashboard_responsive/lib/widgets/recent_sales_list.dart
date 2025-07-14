import 'package:flutter/material.dart';
import 'package:flutter_pos_dashboard_responsive/constants/colors.dart';
import 'package:flutter_pos_dashboard_responsive/constants/constants.dart';
import 'package:flutter_pos_dashboard_responsive/data/recent_sales_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentSalesList extends StatelessWidget {
  const RecentSalesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Penjualan Terakhir',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: AppConstants.defaultPadding,
              columns: const [
                DataColumn(
                  label: Text(
                    'Nama File',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Tanggal',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Jumlah',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
              rows: List.generate(
                recentSales.length,
                (index) => recentSaleDataRow(recentSales[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow recentSaleDataRow(RecentSale saleInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(saleInfo.icon, height: 25, width: 25),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
                child: Text(
                  saleInfo.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(saleInfo.date, style: const TextStyle(color: Colors.white70)),
        ),
        DataCell(
          Text(saleInfo.amount, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

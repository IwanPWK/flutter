import 'package:flutter/material.dart';

class CategoryButtons extends StatelessWidget {
  const CategoryButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Semua Kategori",
      "Makanan",
      "Minuman",
      "Obat",
      "Perlengkapan Mandi",
      "Perlengkapan Bayi",
      "Susu Bayi",
      "Parfum",
      "Sembako",
      "Alat Listrik",
      "Pembersih",
      "Dapur",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            categories.map((cat) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OutlinedButton(onPressed: () {}, child: Text(cat)),
              );
            }).toList(),
      ),
    );
  }
}

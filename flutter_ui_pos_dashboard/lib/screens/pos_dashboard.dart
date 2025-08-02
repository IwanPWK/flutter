import 'package:flutter/material.dart';
import '../widgets/category_buttons.dart';
import '../widgets/product_card.dart';

class PosDashboard extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {"name": "Susu Beruang", "price": 8000, "stock": 96},
    {"name": "Indomie Goreng", "price": 3500, "stock": 231},
    {"name": "Gula Pasir 1Kg", "price": 13500, "stock": 165},
    {"name": "Telur Ayam (1Pak)", "price": 25300, "stock": 115},
    // Tambahkan produk lainnya sesuai gambar...
  ];

  PosDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Kiri: Produk
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Kasir: Nurul", style: TextStyle(fontSize: 18)),
                  Text("${DateTime.now().toLocal()}"),
                  const SizedBox(height: 12),
                  const CategoryButtons(),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Cari atau scan barcode produk...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children:
                          products
                              .map(
                                (product) => ProductCard(
                                  name: product['name'],
                                  price: product['price'],
                                  stock: product['stock'],
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Kanan: Keranjang
          Expanded(
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🛒 Keranjang",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text("Keranjang masih kosong"),
                  const Spacer(),
                  const Text("Subtotal: Rp 0"),
                  const Text("Diskon (Rp):"),
                  const Text(
                    "TOTAL: Rp 0",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  const Text("Uang Tunai:"),
                  const Text("Kembalian: Rp 0"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("BATAL"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("BAYAR"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

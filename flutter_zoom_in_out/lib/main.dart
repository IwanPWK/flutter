import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini POS Zoom',
      debugShowCheckedModeBanner: false,
      home: const MiniPOS(),
    );
  }
}

class MiniPOS extends StatefulWidget {
  const MiniPOS({super.key});
  @override
  State<MiniPOS> createState() => _MiniPOSState();
}

class _MiniPOSState extends State<MiniPOS> {
  double zoom = 1.0; // level zoom awal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini POS"),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                zoom = (zoom - 0.1).clamp(0.5, 3.0);
              });
            },
          ),
          Center(child: Text("${(zoom * 100).toInt()}%")),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                zoom = (zoom + 0.1).clamp(0.5, 3.0);
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.grey[100],
          padding: EdgeInsets.all(16 * zoom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Judul
              Text(
                "Laporan Penjualan",
                style: TextStyle(
                  fontSize: 20 * zoom,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10 * zoom),

              // Chart placeholder
              Container(
                width: 200 * zoom,
                height: 100 * zoom,
                color: Colors.orange[300],
                alignment: Alignment.center,
                child: Text(
                  "Chart Placeholder",
                  style: TextStyle(fontSize: 12 * zoom),
                ),
              ),
              SizedBox(height: 10 * zoom),

              // TextField
              SizedBox(
                width: 200 * zoom,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Nama Produk",
                    labelStyle: TextStyle(fontSize: 14 * zoom),
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: 14 * zoom),
                ),
              ),
              SizedBox(height: 10 * zoom),

              // Button
              SizedBox(
                height: 40 * zoom,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16 * zoom,
                      vertical: 8 * zoom,
                    ),
                  ),
                  child: Text("Proses", style: TextStyle(fontSize: 14 * zoom)),
                ),
              ),
              SizedBox(height: 10 * zoom),

              // Gambar resolusi dinamis
              buildZoomImage(zoom),
            ],
          ),
        ),
      ),
    );
  }

  // Ganti resolusi gambar & ukuran sesuai zoom
  Widget buildZoomImage(double zoom) {
    String imgPath;
    if (zoom > 2.0) {
      imgPath = 'assets/very_large/sample.png'; // resolusi tinggi
    } else if (zoom > 1.5) {
      imgPath = 'assets/large/sample.png';
    } else {
      imgPath = 'assets/sample.png';
    }

    return Image.asset(
      imgPath,
      width: 100 * zoom,
      height: 100 * zoom,
      fit: BoxFit.contain,
    );
  }

  // Widget buildZoomImage(double zoom) {
  //   print('cek nilai zoom $zoom');
  //   String imgPath;
  //   if (zoom > 2.0) {
  //     imgPath = 'assets/very_large/sample.png';
  //   } else if (zoom > 1.5) {
  //     imgPath = 'assets/large/sample.png';
  //   } else {
  //     imgPath = 'assets/sample.png';
  //   }

  //   return Image.asset(
  //     imgPath,
  //     width: 100 * zoom,
  //     height: 100 * zoom,
  //     fit: BoxFit.contain,
  //   );
  // }
}

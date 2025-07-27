import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: OverlayDragColorPage()));
}

class OverlayDragColorPage extends StatefulWidget {
  const OverlayDragColorPage({super.key});

  @override
  State<OverlayDragColorPage> createState() => _OverlayDragColorPageState();
}

class _OverlayDragColorPageState extends State<OverlayDragColorPage> {
  Color targetColor = Colors.grey;
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  OverlayEntry? _overlayEntry;

  void _showOverlayColorPicker() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 150,
          left: 50,
          child: Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Wrap(
                spacing: 10,
                children:
                    colors.map((color) {
                      return Draggable<Color>(
                        data: color,
                        feedback: Container(
                          width: 50,
                          height: 50,
                          color: color.withValues(alpha: 0.7),
                        ),
                        childWhenDragging: Container(
                          width: 50,
                          height: 50,
                          color: color.withValues(alpha: 0.3),
                        ),
                        child: Container(width: 50, height: 50, color: color),
                      );
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );

    // Tampilkan overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Klik di luar untuk menutup overlay
      onTap: () => _removeOverlay(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Drag Warna dari Overlay')),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DragTarget<Color>(
                    onAcceptWithDetails: (details) {
                      setState(() {
                        targetColor = details.data;
                      });
                      _removeOverlay(); // Opsional: Tutup overlay setelah drop
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: targetColor,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Center(
                          child: Text(
                            'Drop warna di sini',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _showOverlayColorPicker,
                    child: const Text('Tampilkan Picker Warna (Overlay)'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: DragColorPage());
  }
}

class DragColorPage extends StatefulWidget {
  const DragColorPage({super.key});

  @override
  State<DragColorPage> createState() => _DragColorPageState();
}

class _DragColorPageState extends State<DragColorPage> {
  Color targetColor = Colors.grey;

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _removeOverlay(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Drag and Drop Warna')),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Wrap(
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
            const SizedBox(height: 40),
            DragTarget<Color>(
              onAcceptWithDetails: (color) {
                setState(() {
                  print('cek nilai ${color.data}');
                  targetColor = color.data;
                });
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Keyboard Shortcut Demo', home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  int _selectedIndex = -1;

  final List<LogicalKeyboardKey> digitKeys = [
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
    LogicalKeyboardKey.digit4,
    LogicalKeyboardKey.digit5,
    LogicalKeyboardKey.digit6,
    LogicalKeyboardKey.digit7,
    LogicalKeyboardKey.digit8,
    LogicalKeyboardKey.digit9,
  ];

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      final isControlPressed =
          event.physicalKey == PhysicalKeyboardKey.controlLeft ||
          event.physicalKey == PhysicalKeyboardKey.controlRight;
      final logicalKey = event.logicalKey;

      if (logicalKey == LogicalKeyboardKey.escape) {
        Navigator.of(context).maybePop();
      }

      // Ctrl + Number (1–9)
      for (int i = 0; i < digitKeys.length; i++) {
        if (logicalKey == digitKeys[i]) {
          setState(() {
            _selectedIndex = i;
          });
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true, // auto fokus agar listener langsung aktif
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        appBar: AppBar(title: const Text('Keyboard Shortcuts')),
        body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            final isSelected = _selectedIndex == index;
            return ListTile(
              title: Text('Item ${index + 1}'),
              tileColor: isSelected ? Colors.blue.shade100 : null,
            );
          },
        ),
      ),
    );
  }
}

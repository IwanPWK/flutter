import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(home: CustomButtonTabNavigation()));
}

class CustomButtonTabNavigation extends StatefulWidget {
  const CustomButtonTabNavigation({super.key});

  @override
  State<CustomButtonTabNavigation> createState() =>
      _CustomButtonTabNavigationState();
}

class _CustomButtonTabNavigationState extends State<CustomButtonTabNavigation> {
  final FocusNode button1Focus = FocusNode();
  final FocusNode button2Focus = FocusNode();
  final FocusNode button3Focus = FocusNode();
  final FocusNode keyboardListenerFocus = FocusNode(); // Tambahkan ini

  late List<FocusNode> focusOrder;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    focusOrder = [button2Focus, button1Focus, button3Focus];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      keyboardListenerFocus.requestFocus(); // Pastikan KeyboardListener fokus
      FocusScope.of(context).requestFocus(focusOrder[currentIndex]);
    });
  }

  void _handleKey(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.keyB) {
      print('currentIndex $currentIndex');
      setState(() {
        currentIndex = (currentIndex + 1) % focusOrder.length;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusOrder[currentIndex]);
      });
    } else if (event is KeyDownEvent &&
        (event.logicalKey != LogicalKeyboardKey.keyB ||
            event.logicalKey != LogicalKeyboardKey.enter)) {
      FocusManager.instance.primaryFocus?.unfocus();
      // Kembalikan fokus ke KeyboardListener agar tetap menerima event
      keyboardListenerFocus.requestFocus();
    }
  }

  // ...existing code...

  void _handlePointerDown(PointerDownEvent event) {
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kPrimaryMouseButton) {
      // Klik kiri mouse → hilangkan fokus
      FocusManager.instance.primaryFocus?.unfocus();
      keyboardListenerFocus.requestFocus();
    }
  }

  @override
  void dispose() {
    button1Focus.dispose();
    button2Focus.dispose();
    button3Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: keyboardListenerFocus, // Gunakan focus node yang sama
      onKeyEvent: _handleKey,
      child: Listener(
        onPointerDown: _handlePointerDown,
        child: Scaffold(
          appBar: AppBar(title: const Text('Custom Button Focus Navigation')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  focusNode: button1Focus,
                  onPressed: () {
                    print('Button 1 Pressed');
                  },
                  child: const Text('Button 1'),
                ),
                ElevatedButton(
                  focusNode: button2Focus,
                  onPressed: () {
                    print('Button 2 Pressed');
                  },
                  child: const Text('Button 2'),
                ),
                ElevatedButton(
                  focusNode: button3Focus,
                  onPressed: () {
                    print('Button 3 Pressed');
                  },
                  child: const Text('Button 3'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tekan B untuk pindah antar tombol (urutan: 2 → 1 → 3)',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

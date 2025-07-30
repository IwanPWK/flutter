import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_detect_user_activity/user_activity_detector.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HardwareKeyboard _keyboard;
  @override
  void initState() {
    super.initState();
    _keyboard = HardwareKeyboard.instance;
    _keyboard.addHandler(_handleKey);
  }

  bool _handleKey(KeyEvent event) {
    print("Keyboard activity detected (new way)");
    return false; // false = biarkan event terus mengalir
  }

  @override
  void dispose() {
    _keyboard.removeHandler(_handleKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        print("Mouse click or tap detected");
      },
      onPointerMove: (_) {
        print("Mouse moved");
      },
      onPointerSignal: (_) {
        print("Mouse scroll or signal detected");
      },
      child: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          print("Keyboard activity detected");
          return KeyEventResult.handled;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: UserActivityDetector(
            child: Center(
              child: Consumer<UserActivityState>(
                builder: (context, state, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('User activity:'),
                      Text(
                        state.activity,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

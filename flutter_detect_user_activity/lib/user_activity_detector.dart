import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserActivityState with ChangeNotifier {
  String _activity = 'No activity yet';

  String get activity => _activity;

  void setActivity(String activity) {
    _activity = activity;
    notifyListeners();
  }
}

class UserActivityDetector extends StatelessWidget {
  final Widget child;
  const UserActivityDetector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserActivityState(),
      child: Builder(
        builder: (context) {
          final state = Provider.of<UserActivityState>(context, listen: false);
          return Listener(
            onPointerDown: (_) => state.setActivity('mouse click'),
            onPointerMove: (_) => state.setActivity('mouse hover'),
            child: Focus(
              onKeyEvent: (_, __) {
                state.setActivity('user typing');
                return KeyEventResult.ignored;
              },
              child: child,
            ),
          );
        },
      ),
    );
  }
}

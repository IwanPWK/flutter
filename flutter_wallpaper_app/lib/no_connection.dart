import 'package:flutter/material.dart';

Widget noConnection(BuildContext context) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off, size: 50, color: Colors.red),
        Text("No Internet Connection"),
      ],
    ),
  );
}

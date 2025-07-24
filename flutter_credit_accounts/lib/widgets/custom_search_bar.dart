import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  // home_screen -> search customer,
  // accountDetailScreen -> search transaction
  final String hintText;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onChange,
  });
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    String query = ''; // we will use the provider for this.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hintText,
          // hintStyle: const TextStyle(color: Colors.white),
          // filled: true,
          // fillColor: lightBlue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            // borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}

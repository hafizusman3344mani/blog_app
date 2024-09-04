import 'package:flutter/material.dart';

class UnFocus extends StatelessWidget {
  final Widget child;
  const UnFocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: child);
  }
}

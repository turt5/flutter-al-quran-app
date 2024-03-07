import 'package:flutter/material.dart';

class IncreaseFontSize extends StatelessWidget {
  const IncreaseFontSize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            // border: Border.all(width: 2, color: Colors.red),
            shape: BoxShape.circle,
            color: Colors.green),
        padding: const EdgeInsets.all(3),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ));
  }
}

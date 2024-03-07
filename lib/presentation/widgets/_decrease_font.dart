import 'package:flutter/material.dart';

class DecreaseFontSize extends StatelessWidget {
  const DecreaseFontSize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            // border: Border.all(width: 2, color: Colors.red),
            shape: BoxShape.circle,
            color: Colors.black),
        padding: const EdgeInsets.all(3),
        child: const Icon(
          Icons.remove,
          color: Colors.white,
        ));
  }
}

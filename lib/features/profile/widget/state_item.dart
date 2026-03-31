import 'package:flutter/material.dart';

class StatItem extends StatelessWidget {
  final String title;
  final String value;

  const StatItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }
}

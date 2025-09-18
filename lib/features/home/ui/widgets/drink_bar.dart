import 'package:flutter/material.dart';

class DrinkBar extends StatelessWidget {
  const DrinkBar({
    super.key,
    required this.label,
    required this.heightFactor,
    required this.color,
    this.highlight = false,
  });

  final String label;
  final double heightFactor;
  final Color color;
  final bool? highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 120 * heightFactor,
          width: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: highlight! ? FontWeight.bold : FontWeight.w500,
            color: highlight! ? color : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

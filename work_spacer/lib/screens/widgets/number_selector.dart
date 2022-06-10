import 'package:flutter/material.dart';

class NumberSelector extends StatelessWidget {
  const NumberSelector({
    Key? key,
    required this.value,
    this.minValue = 1,
    this.maxValue = 12,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  final int value;
  final int minValue;
  final int maxValue;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: value > minValue ? onDecrement : null,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        const SizedBox(width: 12),
        Text(
          '$value',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: value < maxValue ? onIncrement : null,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}

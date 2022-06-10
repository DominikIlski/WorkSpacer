import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool? isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          color: isSelected == null
              ? Colors.white
              : isSelected!
                  ? Theme.of(context).secondaryHeaderColor
                  : Colors.white,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected == null
                      ? Theme.of(context).secondaryHeaderColor
                      : isSelected!
                          ? Colors.white
                          : Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

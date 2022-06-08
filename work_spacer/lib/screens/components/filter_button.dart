import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  FilterButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
    this.selected = false,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClicked();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Theme.of(context).secondaryHeaderColor,
            width: 2,
          ),
        ),
        color: selected
            ? Theme.of(context).secondaryHeaderColor
            : Theme.of(context).primaryColorLight,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: selected
                      ? Colors.white
                      : Theme.of(context).secondaryHeaderColor,
                ),
                const SizedBox(width: 4),
                Text(
                  text,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

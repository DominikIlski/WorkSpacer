import 'package:flutter/material.dart';
import 'package:work_spacer/models/filter.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.filter,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final FilterParameter filter;
  final bool isSelected;
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
          color: isSelected
              ? Theme.of(context).secondaryHeaderColor
              : Colors.white,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                filterParameterNames[filter] ?? '',
                style: TextStyle(
                  color: isSelected
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

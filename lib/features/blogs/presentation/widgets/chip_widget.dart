import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final double vPadding;
  final VoidCallback onTap;
  const ChipWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap,
      this.vPadding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(title),
          color:
              isSelected ? WidgetStateProperty.all(AppPallete.gradient1) : null,
          side: BorderSide(
            color: isSelected ? AppPallete.gradient1 : AppPallete.borderColor,
          ),
        ),
      ),
    );
  }
}

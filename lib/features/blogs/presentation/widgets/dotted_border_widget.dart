import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedBorderWidget extends StatelessWidget {
  final VoidCallback onTap;

  const DottedBorderWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        color: AppPallete.borderColor,
        dashPattern: const [10, 4],
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              iconColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const SizedBox(
            height: 150,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_open,
                  size: 40,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Select your image',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
        ));
  }
}

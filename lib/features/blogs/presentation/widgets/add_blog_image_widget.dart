import 'dart:io';

import 'package:flutter/material.dart';

class AddBlogImageWidget extends StatelessWidget {
  final File image;
  final VoidCallback? onTap;
  const AddBlogImageWidget({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

import 'package:blog_app/core/constants/app_consts.dart';
import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  const AuthGradientButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(AppConsts.authButtonRadius),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConsts.authButtonRadius),
            ),
            fixedSize: Size(
              width ?? MediaQuery.of(context).size.width,
              height ?? AppConsts.authButtonHeight,
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppPallete.whiteColor),
          ),
        ),
      ),
    );
  }
}

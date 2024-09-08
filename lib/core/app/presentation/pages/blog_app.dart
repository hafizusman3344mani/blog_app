import 'package:blog_app/core/di/bloc_di.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/splash_widget.dart';
import '../../../config/theme/app_theme.dart';
import '../../../utils/unfocus.dart';

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocDi(
        child: MaterialApp(
            title: 'Blog App',
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget? child) {
              child = UnFocus(child: child!);
              return child;
            },
            theme: AppTheme.darkThemeMode,
            home: const SplashWidget()));
  }
}

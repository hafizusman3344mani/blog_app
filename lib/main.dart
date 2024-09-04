import 'package:blog_app/core/di/bloc_di.dart';
import 'package:blog_app/core/di/service_locator.dart';
import 'package:flutter/material.dart';

import 'core/config/theme/app_theme.dart';
import 'features/auth/presentation/pages/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await sl.allReady();
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocDi(
      child: MaterialApp(
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        home: const SignUpPage(),
      ),
    );
  }
}

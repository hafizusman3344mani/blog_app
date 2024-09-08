import 'package:blog_app/core/di/service_locator.dart';
import 'package:flutter/material.dart';

import 'core/app/presentation/pages/blog_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await sl.allReady();
  runApp(const BlogApp());
}

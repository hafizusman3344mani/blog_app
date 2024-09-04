import 'package:blog_app/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/auth_bloc.dart';

class BlocDi extends StatelessWidget {
  final Widget child;
  const BlocDi({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<AuthBloc>()),
    ], child: child);
  }
}

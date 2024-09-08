import 'package:blog_app/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/presentation/cubits/app_user_cubit.dart';

class BlocDi extends StatelessWidget {
  final Widget child;
  const BlocDi({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<AppUserCubit>()..checkUser()),
    ], child: child);
  }
}

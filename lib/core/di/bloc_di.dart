import 'package:flutter/material.dart';

class BlocDi extends StatelessWidget {
  final Widget child;
  const BlocDi({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
    // return MultiBlocProvider(providers: [
    //   BlocProvider(create: (context) => sl<AuthBloc>()),
    // ], child: child);
  }
}

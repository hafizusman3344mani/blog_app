import 'package:blog_app/core/config/routes/nav_router.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blogs/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/presentation/cubits/app_user_cubit.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if (state.userStatus == AppUserStatus.error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          NavRouter.pushReplacement(context, const SignInPage());
        }
        if (state.userStatus == AppUserStatus.loaded) {
          if (state.userEntity != null) {
            NavRouter.pushReplacement(context, const BlogPage());
          } else {
            NavRouter.pushReplacement(context, const SignUpPage());
          }
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

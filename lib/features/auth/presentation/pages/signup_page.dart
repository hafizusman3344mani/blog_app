import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/cubit/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/routes/nav_router.dart';
import '../../../../core/di/service_locator.dart';
import '../widget/auth_field.dart';
import '../widget/auth_gradient_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearData() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is AuthLoading) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
            if (state is AuthSuccess) {
              clearData();
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up.',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthField(
                      controller: _nameController,
                      hintText: 'Name',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthField(
                      controller: _passwordController,
                      hintText: 'Password',
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthGradientButton(
                      title: state is AuthLoading ? 'wait...' : 'Sign Up',
                      onPressed: state is AuthLoading
                          ? () {}
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthSignUpEvent(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              } else {}
                            },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavRouter.push(context, const SignInPage());
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppPallete.gradient2,
                                        fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

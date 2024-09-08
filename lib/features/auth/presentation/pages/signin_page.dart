import 'package:blog_app/core/app_text_field.dart';
import 'package:blog_app/core/config/routes/nav_router.dart';
import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../cubit/auth_bloc.dart';
import '../widget/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearData() {
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
              print(state.user.name);
              clearData();
              //TODO: AuthSuccess State emitted in Signin page
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
                      'Sign In.',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      isObscureText: true,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthGradientButton(
                      title: state is AuthLoading ? 'wait...' : 'Sign In',
                      onPressed: state is AuthLoading
                          ? () {}
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthSignInEvent(
                                        password:
                                            _passwordController.text.trim(),
                                        email: _emailController.text.trim(),
                                      ),
                                    );
                                return;
                              } else {
                                //Todo: show error in validation
                              }
                            },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavRouter.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign Up',
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

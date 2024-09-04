import 'package:blog_app/core/config/routes/nav_router.dart';
import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:flutter/material.dart';

import '../widget/auth_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
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
                title: 'Sign In',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
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
      ),
    );
  }
}

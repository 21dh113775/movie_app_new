import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/helper/navigation/app_navigation.dart';
import 'package:movie_app/core/configs/theme/app_colors.dart';
import 'package:movie_app/presentation/auth/pages/signup.dart';
import 'package:reactive_button/reactive_button.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signinText(),
              const SizedBox(height: 30),
              _emailField(),
              const SizedBox(height: 20),
              _passwordField(),
              const SizedBox(height: 60),
              _signinButton(),
              const SizedBox(
                height: 20,
              ),
              _signupText(context)
            ],
          )),
    );
  }

  Widget _signinText() {
    return const Text(
      "Đăng Nhập Tài Khoản",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _emailField() {
    return const TextField(
      decoration: InputDecoration(hintText: 'Email'),
    );
  }

  Widget _passwordField() {
    return const TextField(
      decoration: InputDecoration(hintText: 'Nhập mật khẩu'),
    );
  }

  Widget _signinButton() {
    return ReactiveButton(
        title: 'Đăng Nhập',
        activeColor: AppColors.primary,
        onPressed: () async {},
        onSuccess: () {},
        onFailure: (error) {});
  }

  Widget _signupText(BuildContext context) {
    return Text.rich(TextSpan(children: [
      const TextSpan(text: "Bạn chưa có tài khoản?"),
      TextSpan(
          text: ' Đăng Ký',
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, SignupPage());
            })
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redd_clone/core/common/loader.dart';
import 'package:redd_clone/core/common/sign_in_button.dart';
import 'package:redd_clone/core/constants/constants.dart';
import 'package:redd_clone/features/auth/controller/auth_controller.dart';
import 'package:redd_clone/responsive/responsive.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logopath,
          height: 40,
        ),
        centerTitle: true,
        actions: [
          TextButton(
          onPressed: () => signInAsGuest(ref, context),
          child: const Text(
            'Skip',
             style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          ),
          ),
        ],
      ),
      body: isLoading? const Loader():Column(
        children: [
          const SizedBox(height: 30),
          const Text('Dive into anything',
           style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              Constants.loginEmotePath,
              height: 400
            , alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 20),
          const Responsive(child: SignInButton()),

        ],
      ),
    );
  }
}
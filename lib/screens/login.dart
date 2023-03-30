import 'package:asdigi/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../helpers/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Icon showPasswordIcon = Icon(Icons.visibility_off);
  bool showPassword = false;

  String? emailErrorText;
  String? passwordErrorText;

  late Widget loginButtonChild;
  late Widget googleSignInButtonChild;
  late Widget loginLoadingWidget;

  bool logInLoading = false;
  bool googleSignInLoading = false;

  @override
  void initState() {
    super.initState();

    loginLoadingWidget = const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
    loginButtonChild = const Text('Login');
    googleSignInButtonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Constants.googleLogoPath,
          height: 18,
        ),
        const SizedBox(
          width: 8,
        ),
        const Text('Sign in with Google'),
      ],
    );
  }

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
      showPasswordIcon = showPassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off);
    });
  }

  void validateEmailPassword(FirebaseAuthException? e) {
    setState(() {
      if (e == null) {
        emailErrorText = null;
        passwordErrorText = null;
        return;
      }
      // Validate email
      if (emailController.text.isEmpty) {
        emailErrorText = 'Email is required';
      } else if (e.code == 'invalid-email') {
        emailErrorText = 'Invalid email';
      } else if (e.code == 'user-not-found') {
        emailErrorText = 'User not found';
      } else {
        emailErrorText = null;
      }

      // Validate password
      if (passwordController.text.isEmpty) {
        passwordErrorText = 'Password is required';
      } else if (e.code == 'wrong-password') {
        passwordErrorText = 'Wrong password';
      } else {
        passwordErrorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            Constants.logoPath,
                            width: 62,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Log in to your account',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              errorText: emailErrorText,
                              isDense: true,
                              border: const OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                              errorText: passwordErrorText,
                              isDense: true,
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  toggleShowPassword();
                                },
                                icon: showPasswordIcon,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: const Text('Forgot Password?'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () async {
                          setState(() {
                            logInLoading = true;
                          });
                          AuthServices()
                              .signInWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                          )
                              .then((error) {
                            validateEmailPassword(error);
                            setState(() {
                              logInLoading = false;
                            });
                          });
                        },
                        child: logInLoading
                            ? loginLoadingWidget
                            : loginButtonChild,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'OR',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () async {
                          await AuthServices().signInWithGoogle();
                        },
                        child: googleSignInButtonChild,
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterPage();
                              },
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          'Register here',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

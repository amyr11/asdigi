import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../helpers/auth_services.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;

  bool registerLoading = false;

  late Widget registerButtonChild;
  late Widget registerLoadingWidget;

  @override
  void initState() {
    super.initState();

    registerLoadingWidget = const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
    registerButtonChild = const Text('Register');
  }

  bool preValidateFields() {
    bool isValid = true;

    setState(() {
      emailErrorText = null;
      passwordErrorText = null;
      confirmPasswordErrorText = null;
    });

    // Validate email
    if (emailController.text.isEmpty) {
      setState(() {
        emailErrorText = 'Email cannot be empty';
      });
      isValid = false;
    } else if (!emailController.text.contains('@')) {
      setState(() {
        emailErrorText = 'Email is not valid';
      });
      isValid = false;
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      setState(() {
        passwordErrorText = 'Password cannot be empty';
      });
      isValid = false;
    } else if (passwordController.text.length < 8) {
      setState(() {
        passwordErrorText = 'Password must be at least 8 characters';
      });
      isValid = false;
    }

    // Validate confirm password
    if (confirmPasswordController.text.isEmpty) {
      setState(() {
        confirmPasswordErrorText = 'Confirm password cannot be empty';
      });
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      setState(() {
        confirmPasswordErrorText = 'Passwords do not match';
      });
      isValid = false;
    }

    return isValid;
  }

  void validateEmailPassword(FirebaseAuthException e) {
    emailErrorText = null;
    passwordErrorText = null;
    confirmPasswordErrorText = null;

    // Validate email
    if (e.code == 'email-already-in-use') {
      setState(() {
        emailErrorText = 'Email is already in use';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 40,
                ),
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
                      'Create an account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: passwordErrorText,
                    isDense: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: confirmPasswordErrorText,
                    isDense: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () async {
                    bool isValid = preValidateFields();
                    if (isValid) {
                      setState(() {
                        registerLoading = true;
                      });
                      AuthServices()
                          .createUserWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      )
                          .then((error) {
                        if (error == null) {
                          Navigator.pop(context);
                        } else {
                          validateEmailPassword(error);
                          setState(() {
                            registerLoading = false;
                          });
                        }
                      });
                    }
                  },
                  child: registerLoading
                      ? registerLoadingWidget
                      : registerButtonChild,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

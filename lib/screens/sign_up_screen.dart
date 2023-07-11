import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/services/authService.dart';
import 'package:ecommerce_app/widgets/password_wiget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    password.dispose();
    email.dispose();
    name.dispose();
  }

  Future handleSignUp(BuildContext context) async {
    setState(() {
      loading = true;
    });
    try {
      await AuthService.signUp(
          context,
          {
            "name": name.text,
            "email": email.text,
            "password": password.text,
            "avatar": "https://api.lorem.space/image/face?w=640&h=480&r=867"
          },
          ref);
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(CONTAINER_PADDING),
          child: Column(
            children: [
              const Text(
                "CSX",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w400,
                  fontSize: 60,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please input name";
                  } else {
                    return null;
                  }
                },
                controller: name,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please input email";
                  } else {
                    return null;
                  }
                },
                controller: email,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordWidget(password: password),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      icon: loading
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Container(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                handleSignUp(context);
                              }
                            },
                      label: const Text('Sign Up'))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      onPressed: loading
                          ? null
                          : () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                      child: const Text('Sign in instead'))),
            ],
          ),
        ),
      ),
    );
  }
}

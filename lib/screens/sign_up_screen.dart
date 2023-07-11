import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/widgets/password_wiget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    password.dispose();
    email.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      return "Please input email";
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
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                        child: const Text('Sign Up'))),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink),
                        onPressed: () {
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
      ),
    );
  }
}

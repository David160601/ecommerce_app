import 'package:dio/dio.dart';
import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/screens/sign_up_screen.dart';
import 'package:ecommerce_app/screens/tab_screen.dart';
import 'package:ecommerce_app/services/authService.dart';
import 'package:ecommerce_app/widgets/password_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final storage = new FlutterSecureStorage();
  LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  var hidePassword = true;
  var email = TextEditingController();
  var password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final dio = Dio();
  var loading = false;
  Future<void> handleLoginAndNavigate(BuildContext context) async {
    try {
      setState(() {
        loading = true;
      });
      await AuthService.login(
          context, {"email": email.text, "password": password.text}, ref);
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    password.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(CONTAINER_PADDING),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Align(
                child: Text(
                  "CSX",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.w400,
                    fontSize: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input email';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordWidget(
                password: password,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              handleLoginAndNavigate(context);
                            } else {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                            }
                          },
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
                    label: const Text('Login'),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: loading
                          ? null
                          : () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                      child: const Text("Sign Up")))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:ecommerce_app/screens/tab_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var hidePassword = true;
  var email = TextEditingController();
  var password = TextEditingController();
  final dio = Dio();
  var loading = false;
  Future<void> handleLoginAndNavigate(BuildContext context) async {
    setState(() {
      loading = true;
    });
    try {
      var response = await dio.post(
        'https://api.escuelajs.co/api/v1/auth/login',
        data: {'email': email.text, "password": password.text},
      );
      setState(() {
        loading = false;
      });
      if (response.statusCode == 201) {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen()),
        );
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password')),
        );
      }
    } catch (e) {
      if (e is DioException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }

      setState(() {
        loading = false;
      });
      // Handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
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
              TextField(
                controller: email,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(hidePassword
                        ? Icons.remove_red_eye
                        : Icons.visibility_off),
                  ),
                ),
                obscureText: hidePassword,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed:
                        loading ? null : () => handleLoginAndNavigate(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.pink,
                      // Background color
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}

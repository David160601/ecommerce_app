import 'package:flutter/material.dart';

class PasswordWidget extends StatefulWidget {
  TextEditingController password;
  PasswordWidget({super.key, required this.password});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidePassword,
      controller: widget.password,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input Password';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Password",
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: Icon(
                hidePassword ? Icons.remove_red_eye : Icons.visibility_off),
          )),
    );
  }
}

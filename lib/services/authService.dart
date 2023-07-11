import 'dart:convert';

import 'package:ecommerce_app/constant/api.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/screens/tab_screen.dart';
import 'package:ecommerce_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthService {
  static Future<void> login(FlutterSecureStorage storage, BuildContext context,
      Map<String, String> body, WidgetRef ref) async {
    try {
      var response = await ApiService.httpPost(loginUri, body);
      if (response.statusCode == 201) {
        var body = jsonDecode(response.body);
      
        ref.read(authProvider.notifier).setToken(body["access_token"]);
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen()),
        );
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Incorrect password or email")));
        throw ("Incorrect password or email");
      }
    } catch (e) {
      throw ("Error during login");
    }
  }

  static Future<void> signUp(FlutterSecureStorage storage, BuildContext context,
      Map<String, String> body, WidgetRef ref) async {
    try {
      var response = await ApiService.httpPost(checkEmailUri, body);
      if (response.statusCode == 201) {
        // do nothing
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Sign Up Error")));
        throw ("Sign Up error");
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error during sign up")));
      throw ("Error during sign up");
    }
  }
}

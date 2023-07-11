import 'dart:convert';
import 'dart:math';

import 'package:ecommerce_app/constant/api.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/screens/tab_screen.dart';
import 'package:ecommerce_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthService {
  static Future<void> login(
      BuildContext context, Map<String, String> body, WidgetRef ref) async {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      var response = await ApiService.httpPost(loginUri, body);
      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        ref.read(authProvider.notifier).setToken(responseBody["access_token"]);
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen()),
        );
      } else {
        throw Exception("Incorrect email or password");
      }
    } catch (e) {
      if (e is Exception &&
          e.toString().contains("Incorrect email or password")) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Incorrect email or password")));
        throw Exception("Incorrect email or password");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error during login")));
        throw Exception("Error during login");
      }
    }
  }

  static Future<void> signUp(
      BuildContext context, Map<String, String> body, WidgetRef ref) async {
    try {
      var response = await ApiService.httpPost(signUpUri, body);
      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        if (!context.mounted) return;
        await login(
            context,
            {
              "email": responseBody["email"]!,
              "password": responseBody["password"]!
            },
            ref);
      } else {
        if (!context.mounted) return;
        throw BadRequestException("bad request exception");
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is BadRequestException) {
        // Handle the "Bad Request" exception
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Bad Request. Please check your request.")));
        throw BadRequestException("bad request exception");
      } else {
        // Handle other exceptions or errors
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error during sign up")));
        throw Exception("Error during sign up");
      }
    }
  }
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException([this.message = "Bad Request"]);

  @override
  String toString() {
    return "BadRequestException: $message";
  }
}

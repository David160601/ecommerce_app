import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthNotifier extends StateNotifier<String?> {
  AuthNotifier() : super(null) {
    _initializeState();
  }
  final storage = new FlutterSecureStorage();

  void setToken(String? token) {
    state = token;
  }

  void removeToken() async {
    state = null;
    await storage.delete(key: "access_token");
  }

  Future<void> _initializeState() async {
    final storedToken = await storage.read(key: "access_token");
    state = storedToken;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, String?>((ref) {
  return AuthNotifier();
});

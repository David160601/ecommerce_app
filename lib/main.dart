import 'package:ecommerce_app/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = FlutterSecureStorage();
  String? accessToken = await storage.read(key: "access_token");

  runApp(
    ProviderScope(
      child: MyApp(
        accessToken: accessToken,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? accessToken;
  const MyApp({super.key, required this.accessToken});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          iconTheme: const IconThemeData(color: Colors.pink),
          appBarTheme: const AppBarTheme(
              actionsIconTheme: IconThemeData(color: Colors.pink),
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.pink),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20))),
      home: const TabsScreen(),
    );
  }
}

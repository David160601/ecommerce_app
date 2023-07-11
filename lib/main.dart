import 'package:ecommerce_app/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
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
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          brightness: Brightness.light,
          iconTheme: const IconThemeData(color: Colors.pink),
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
              titleMedium: TextStyle(fontWeight: FontWeight.bold),
              titleLarge: TextStyle(fontWeight: FontWeight.bold),
              bodySmall: TextStyle(color: Colors.black),
              headlineLarge: TextStyle(color: Colors.black)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                    vertical: 15), // Adjust the padding as needed
              ),
            ),
          ),
          dividerColor: Colors.pink,
          appBarTheme: const AppBarTheme(
              elevation: 0,
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

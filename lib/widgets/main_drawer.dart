import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? token = ref.watch(authProvider);
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.pink,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                token == null || token.isEmpty
                    ? Container()
                    : const CircleAvatar(
                        radius: 80 / 3,
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg"),
                      ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: token == null || token.isEmpty
                      ? const Text(
                          'Login/Sign up',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      : TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.pink,
                          ),
                          onPressed: () {
                            ref.read(authProvider.notifier).removeToken();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: const Text(
                            "log out",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          )),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Row(children: [
              Icon(Icons.settings),
              SizedBox(
                width: 20,
              ),
              Text('Setting')
            ]),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/screens/categories_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/widgets/main_app_bar.dart';
import 'package:ecommerce_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var screenBodyIndex = 0;
  var screenTitle = "Home";
  Widget screenBody = const HomeScreen();
  void onChangeScreen(i) {
    setState(() {
      screenBodyIndex = i;
      if (i == 0) {
        screenTitle = "Home";
        screenBody = const HomeScreen();
      } else if (i == 1) {
        screenTitle = "Categories";
        screenBody = const CategorieScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      body: screenBody,
      appBar: MainAppBar(
    title: screenTitle,
      ),
      bottomNavigationBar: SalomonBottomBar(
      currentIndex: screenBodyIndex,
      backgroundColor: Colors.white,
      onTap: onChangeScreen,
      items: [
        /// Home
        SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.pink,
            unselectedColor: Colors.grey),

        /// Likes
        SalomonBottomBarItem(
            icon: const Icon(Icons.category),
            title: const Text("Categories"),
            selectedColor: Colors.pink,
            unselectedColor: Colors.grey),
      ]),
    );
  }
}

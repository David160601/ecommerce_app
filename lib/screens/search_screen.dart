import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  var search = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: (value) {
            setState(() {
              search = searchController.text;
            });
          },
          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.pink,
              ),
            ),
            hintText: "Search",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors
                      .grey.shade300), // Set your desired border color here
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors
                      .grey.shade300), // Set your desired border color here
            ),
          ),
        ),
      ),
      body: Center(child: Text(search)),
    ));
  }
}

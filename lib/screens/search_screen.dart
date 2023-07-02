import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  var search = "";
  List<Product> searchProducts = [];
  var loading = false;
  Future fetch() async {
    setState(() {
      loading = true;
    });
    var response = await Dio().get(
        "https://api.escuelajs.co/api/v1/products?title=${searchController.text}&limit=100");
    List<Product> responseProducts = [];
    if (response.statusCode == 200) {
      for (var item in response.data) {
        responseProducts.add(Product.fromJson(item));
      }
      setState(() {
        searchProducts = responseProducts;
      });
    } else {
      throw Exception("Error");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: TextField(
          onSubmitted: (value) {
            setState(() {
              search = searchController.text;
            });
            if (searchController.text.isNotEmpty) {
              fetch();
            }
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            )
          : search.isNotEmpty && searchProducts.isEmpty
              ? const Center(
                  child: Text("Result not found"),
                )
              : Column(children: [
                  search.isEmpty
                      ? Container()
                      : Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Result : ${searchProducts.length}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.settings_input_component))
                            ],
                          ),
                        ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                        itemCount: searchProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          final product = searchProducts?[index];
                          if (product != null) {
                            return ProductCard(product: product);
                          } else {
                            return Container();
                          }
                        }),
                  ))
                ]),
    ));
  }
}

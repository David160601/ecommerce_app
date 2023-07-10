import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/widgets/filter_widget.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues currentRangeValues = const RangeValues(0, 2000);
  var searchController = TextEditingController();
  var search = "";
  var loading = false;
  var categoriesLoading = false;
  List<Product> searchProducts = [];
  List<Category> categories = [];
  Future fetch() async {
    setState(() {
      loading = true;
    });
    var response = await Dio().get(
        "https://api.escuelajs.co/api/v1/products?title=${searchController.text}&limit=100&price_min=${currentRangeValues.start.toInt().toString()}&price_max=${currentRangeValues.end.toInt().toString()}");
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

  void filterSubmit(RangeValues values) async {
    currentRangeValues = values;
    if (search.isNotEmpty) {
      fetch();
    }
  }

  Future getCategories() async {
    setState(() {
      categoriesLoading = true;
    });
    var response =
        await Dio().get("https://api.escuelajs.co/api/v1/categories/");
    List<Category> responseCategories = [];
    if (response.statusCode == 200) {
      for (var item in response.data) {
        responseCategories.add(Category.fromJson(item));
      }
    }
    categories = responseCategories;
    setState(() {
      categoriesLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: TextField(
          onSubmitted: (value) {
            if (search != searchController.text) {
              setState(() {
                search = searchController.text;
              });
              if (searchController.text.isNotEmpty) {
                fetch();
              }
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
          : Column(children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    search.isNotEmpty
                        ? Text(
                            "Result : ${searchProducts.length}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Container(),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SearchFilterBody(
                                  currentRangeValues: currentRangeValues,
                                  filterSubmit: filterSubmit,
                                );
                              });
                        },
                        icon: const Icon(Icons.settings_input_component))
                  ],
                ),
              ),
              Expanded(
                  child: search.isNotEmpty && searchProducts.isEmpty
                      ? const Center(
                          child: Text("Result not found"),
                        )
                      : Container(
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

import 'package:dio/dio.dart';
import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/services/category_service.dart';
import 'package:ecommerce_app/services/product_service.dart';
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
  Category? selectedCategory;
  List<Product> searchProducts = [];
  List<Category> categories = [];
  Future fetch() async {
    String? categoryId = selectedCategory?.id?.toString();
    setState(() {
      loading = true;
    });
    List<Product> responseProducts =
        await ProductService.getProducts(queryParams: {
      "title": searchController.text,
      "limit": "100",
      "price_min": currentRangeValues.start.toString(),
      "price_max": currentRangeValues.end.toString(),
      "categoryId": categoryId ?? ""
    });
    setState(() {
      searchProducts = responseProducts;
    });
    setState(() {
      loading = false;
    });
  }

  Future fetchCategories() async {
    setState(() {
      categoriesLoading = true;
    });
    List<Category> responseCategories = await CategoryService.getCategoryies();
    setState(() {
      categories = responseCategories;
    });
    setState(() {
      categoriesLoading = false;
    });
  }

  void filterSubmit(RangeValues values, Category? category) async {
    currentRangeValues = values;
    selectedCategory = category;
    if (search.isNotEmpty) {
      fetch();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CONTAINER_PADDING,
                      horizontal: CONTAINER_PADDING),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      search.isNotEmpty
                          ? Text(
                              "Result : ${searchProducts.length}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Container(),
                      categoriesLoading
                          ? const CircularProgressIndicator()
                          : IconButton(
                              splashRadius: ICON_SPLASH_RADIUS,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SearchFilterBody(
                                      currentRangeValues: currentRangeValues,
                                      categories: categories,
                                      filterSubmit: filterSubmit,
                                      selectedCategory: selectedCategory,
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.settings_input_component))
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: search.isNotEmpty && searchProducts.isEmpty
                      ? const Center(
                          child: Text("Result not found"),
                        )
                      : Container(
                          padding: const EdgeInsets.all(CONTAINER_PADDING),
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
    );
  }
}

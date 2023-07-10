import 'package:dio/dio.dart';
import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<CategoryScreen> {
  RangeValues currentRangeValues = const RangeValues(0, 2000);
  List<Product> products = [];
  var loading = false;
  var offset = 0;
  final controller = ScrollController();
  var scrollLoading = false;
  var end = false;
  Future fetch() async {
    var response = await Dio().get(
        "https://api.escuelajs.co/api/v1/products?price_min=${currentRangeValues.start.toInt().toString()}&price_max=${currentRangeValues.end.toInt().toString()}&categoryId=${widget.category.id ?? 1}&limit=10&offset=${offset}");
    List<Product> responseProducts = [];
    if (response.statusCode == 200) {
      for (var item in response.data) {
        responseProducts.add(Product.fromJson(item));
      }
      setState(() {
        if (responseProducts.isEmpty) {
          end = true;
        } else {
          offset += responseProducts.length;
          products.addAll(responseProducts);
        }
      });
    } else {
      throw Exception("Error");
    }
  }

  Future firstFetch() async {
    setState(() {
      loading = true;
    });
    await fetch();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    firstFetch();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (!end && !scrollLoading && !loading) {
          setState(() {
            scrollLoading = true;
          });
          await fetch();
          setState(() {
            scrollLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name ?? ""),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(CONTAINER_PADDING),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(children: [
            Text(
              "Price range 0 - 2000 \$",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            RangeSlider(
              values: currentRangeValues,
              max: 2000,
              divisions: 5,
              labels: RangeLabels(
                currentRangeValues.start.round().toString(),
                currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  currentRangeValues = values;
                });
              },
              onChangeEnd: (RangeValues values) {
                setState(() {
                  end = false;
                  offset = 0;
                  products = [];

                  firstFetch();
                });
              },
            ),
            const Divider(
              height: 30,
            )
          ]),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: CONTAINER_PADDING),
            child: loading
                ? GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return SkeletonLine(
                        style: SkeletonLineStyle(
                            height: double.maxFinite,
                            borderRadius: BorderRadius.circular(20)),
                      );
                    })
                : products.isEmpty
                    ? const Center(
                        child: Text("No data available"),
                      )
                    : GridView.builder(
                        controller: controller,
                        itemCount: scrollLoading
                            ? products.length + 2
                            : products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          if (index < products.length) {
                            final product = products?[index];
                            if (product != null) {
                              return ProductCard(product: product);
                            } else {
                              return Container();
                            }
                          } else {
                            return const SkeletonLine(
                              style: SkeletonLineStyle(height: double.infinity),
                            );
                          }
                        }),
          ),
        )
      ]),
    ));
  }
}

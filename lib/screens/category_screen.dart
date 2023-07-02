import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/widgets/main_app_bar.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<CategoryScreen> {
  RangeValues currentRangeValues = const RangeValues(0, 2000);
  List<Product> products = [];
  var loading = true;
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);
  Future<List<Product>> getProducts(int categoryId) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().get(
        "https://api.escuelajs.co/api/v1/products?price_min=${currentRangeValues.start}&price_max=${currentRangeValues.end}&categoryId=${categoryId}&limit=10&offset=0");
    List<Product> products = [];

    if (response.statusCode == 200) {
      for (var item in response.data) {
        products.add(Product.fromJson(item));
      }
    }

    setState(() {
      loading = false;
    });
    return products;
  }

  @override
  void initState() {
    super.initState();
    getProducts(widget.category.id ?? 1).then((value) {
      products = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: MainAppBar(title: widget.category.name ?? ""),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(children: [
            const Text("Price range 0 - 2000 \$"),
            RangeSlider(
              activeColor: Colors.pink,
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
                  getProducts(widget.category.id ?? 1).then((value) {
                    products = value;
                  });
                });
              },
            ),
            Divider(
              height: 30,
              color: Colors.pink.shade200,
            )
          ]),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: loading
                ? GridView.builder(
                    itemCount: 20,
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
                : GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      final product = products?[index];
                      if (product != null) {
                        return ProductCard(product: product);
                      } else {
                        return Container();
                      }
                    }),
          ),
        )
      ]),
    ));
  }
}

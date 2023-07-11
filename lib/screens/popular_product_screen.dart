import 'package:ecommerce_app/constant/style.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:ecommerce_app/widgets/cart_icon.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class PopularProductScreen extends StatelessWidget {
  const PopularProductScreen({super.key});
  Future<List<Product>> getProducts() async {
    try {
      return ProductService.getProducts();
    } catch (e) {
      throw ("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Product"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(20),
            child: CardIcon(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(CONTAINER_PADDING),
        child: FutureBuilder<List<Product>>(
          future: getProducts(), // a previously-obtained Future<String> or null
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            Widget children;
            if (snapshot.hasData) {
              children = GridView.builder(
                itemCount: snapshot.data?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  var product = snapshot.data?[index];
                  if (product == null) {
                    return Container();
                  } else {
                    return ProductCard(product: product);
                  }
                },
              );
            } else if (snapshot.hasError) {
              children = const Center(
                child: Center(child: Text("Error")),
              );
            } else {
              children = const Center(
                child: CircularProgressIndicator(),
              );
            }
            return children;
          },
        ),
      ),
    );
  }
}

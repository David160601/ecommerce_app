import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? ""),
      ),
      body: Column(children: [
        FadeInImage(
            height: height * 0.4,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(widget.product.images?.isNotEmpty == true
                ? widget.product.images![0]
                : '')),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$ ${widget.product.price.toString()}" ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.product.description ?? ''),
              ],
            ))
      ]),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(foregroundColor: Colors.pink),
          child: const Text("Add to cart"),
        ),
      ),
    );
  }
}

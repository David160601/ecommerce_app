import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Color.fromARGB(255, 241, 225, 230),
      onTap: () {},
      child: Ink(
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "\$ ${widget.product.price ?? ""}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                width: double.maxFinite,
                child: FadeInImage(
                    fit: BoxFit.cover,
                    height: height * 0.5,
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                        widget.product.images?.isNotEmpty == true
                            ? widget.product.images![0]
                            : '')),
              ),
            ),
            Flexible(
                child: Text(
              widget.product.title ?? '',
              overflow: TextOverflow.ellipsis,
            )),
            const SizedBox(height: 3)
          ],
        ),
      ),
    );
  }
}

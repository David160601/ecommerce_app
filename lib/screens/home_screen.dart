import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/product_%20model.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:ecommerce_app/widgets/slide_item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Product>> getSliderProducts() async {
    var response = await Dio()
        .get('https://api.escuelajs.co/api/v1/products/?offset=0&limit=6');
    List<Product> products = [];
    if (response.statusCode == 200) {
      for (var item in response.data) {
        products.add(Product.fromJson(item));
      }
    }
    return products;
  }

  Future<List<Product>> getPopularProducts() async {
    var response = await Dio()
        .get('https://api.escuelajs.co/api/v1/products/?offset=10&limit=6');
    List<Product> products = [];
    if (response.statusCode == 200) {
      for (var item in response.data) {
        products.add(Product.fromJson(item));
      }
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              TextField(
                readOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.pink,
                  ),
                  hintText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.grey
                            .shade300), // Set your desired border color here
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.grey
                            .shade300), // Set your desired border color here
                  ),
                ),
              ),
             const Divider(
                height: 30,
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(children: [
                FutureBuilder<List<Product>>(
                  future: getSliderProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    Widget children;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      children = SkeletonLine(
                        style: SkeletonLineStyle(
                            height: height * 0.20,
                            padding:
                                const EdgeInsets.only(left: 20, right: 20)),
                      );
                    } else if (snapshot.hasError) {
                      children = SkeletonLine(
                        style: SkeletonLineStyle(
                            height: height * 0.20,
                            padding:
                                const EdgeInsets.only(left: 20, right: 20)),
                      );
                    } else {
                      if (snapshot.data?.isEmpty == true) {
                        children = Container();
                      } else {
                        children = CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1.0,
                            enlargeCenterPage: true,
                            height: height * 0.20,
                          ),
                          items: snapshot.data?.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return SlideItem(product: i);
                              },
                            );
                          }).toList(),
                        );
                      }
                    }
                    return children;
                  },
                ),
                FutureBuilder<List<Product>>(
                  future: getPopularProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    Widget children;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      children = Column(
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          const SkeletonLine(
                            style: SkeletonLineStyle(
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                return SkeletonLine(
                                  style: SkeletonLineStyle(
                                      borderRadius: BorderRadius.circular(20),
                                      height: double.infinity),
                                );
                              }),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      children = Column(
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          const SkeletonLine(
                            style: SkeletonLineStyle(
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                return SkeletonLine(
                                  style: SkeletonLineStyle(
                                      borderRadius: BorderRadius.circular(20),
                                      height: double.infinity),
                                );
                              }),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    } else {
                      if (snapshot.data?.isEmpty == true) {
                        children = Container();
                      } else {
                        children = Column(
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Popular product",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_right))
                              ],
                            ),
                            GridView.builder(
                                shrinkWrap: true,
                                itemCount: 6,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemBuilder: (context, index) {
                                  final product = snapshot.data?[index];
                                  if (product != null) {
                                    return ProductCard(product: product);
                                  } else {
                                    return Container();
                                  }
                                }),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }
                    }
                    return children;
                  },
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

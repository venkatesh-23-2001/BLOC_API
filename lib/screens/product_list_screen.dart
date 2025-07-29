import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:test_form/model/product_model.dart';
import 'package:test_form/product_bloc/product_bloc.dart';
import 'package:test_form/product_bloc/product_event.dart';
import 'package:test_form/product_bloc/product_state.dart';
import 'package:test_form/screens/product_overview_screen.dart';
import 'package:test_form/widgets/search_bar_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> productsList = [];
  List<ProductModel> searchProductList = [];
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    initialLoad();
    super.initState();
  }

  Future<void> initialLoad() async {
    await context.read<ProductCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch
          ? SearchBarWidget(
              textEditingController: searchController,
              onClose: () {
                searchProductList = productsList;
                searchController.clear();
                setState(() => isSearch = false);
              },
              onChange: (value) {
                setState(() {
                  searchProductList =
                      productsList.where((e) => e.name!.toLowerCase().contains(value.toLowerCase())).toList();
                });
              },
            )
          : AppBar(
              backgroundColor: Colors.black,
              leading: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              title: Text(
                "MWS",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      searchProductList = productsList;
                      setState(() => isSearch = true);
                    },
                    icon: Icon(
                      (Icons.search),
                      color: Colors.white,
                    ))
              ],
            ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductSuccessState) {
            productsList = state.productList;
            bool isEmpty = isSearch ? searchProductList.isEmpty : productsList.isEmpty;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: isSearch ? searchProductList.length : productsList.length,
                  itemBuilder: (listviewContext, index) {
                    final product = isSearch ? searchProductList[index] : productsList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ProductOverviewScreen(productModel: product)));
                        },
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: CachedNetworkImage(
                                    imageUrl: product.imageLink ?? '',
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                                Text(
                                  product.name ?? '',
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  product.brand ?? '',
                                  style: TextStyle(color: Colors.black, fontSize: 14),
                                ),
                                Text(
                                  product.price ?? '',
                                  style: TextStyle(color: Colors.black, fontSize: 14),
                                ),
                                RatingStars(
                                  value: product.rating ?? 0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Center(
              child: Text("Fetch Failed."),
            );
          }
        },
      ),
    );
  }
}

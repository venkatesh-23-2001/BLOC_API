import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:test_form/model/product_model.dart';

class ProductOverviewScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductOverviewScreen({super.key, required this.productModel});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.productModel.brand ?? ''),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  color: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl: widget.productModel.imageLink ?? '',
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Text("Product Name : ${widget.productModel.name ?? ''}"),
              Text("Product Type : ${widget.productModel.productType ?? ''}"),
              Text("Created At : ${widget.productModel.createdAt ?? ''}"),
              Text("Updated At : ${widget.productModel.updatedAt ?? ''}"),
              RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Product Link : ",style: TextStyle(color: Colors.black)),
                  TextSpan(text: widget.productModel.productLink ?? '', style: TextStyle(color: Colors.blue))
                ]),
              ),
              Text("Rating"),
              RatingStars(
                value: widget.productModel.rating ?? 0,
              ),
              Text("Description : ${widget.productModel.description ?? ''}"),
            ],
          ),
        ),
      ),
    );
  }
}

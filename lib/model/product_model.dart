class ProductModel {
  final String? brand;
  final String? name;
  final String? price;
  final String? imageLink;
  final String? description;
  final double? rating;
  final String? productLink;
  final String? productType;
  final String? createdAt;
  final String? updatedAt;
  ProductModel({
    this.name,
    this.brand,
    this.description,
    this.imageLink,
    this.price,
    this.rating,
    this.createdAt,
    this.productLink,
    this.productType,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      imageLink: json['image_link'],
      price: json['price'],
      rating: json['rating'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productLink: json['product_link'],
      productType: json['product_type']
    );
  }
}

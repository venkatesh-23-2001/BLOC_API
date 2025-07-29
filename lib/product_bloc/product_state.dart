import 'package:test_form/model/product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  final String successMessage;
  final List<ProductModel> productList;
  ProductSuccessState({required this.successMessage, required this.productList});
}

class ProductErrorState extends ProductState {
  final String errorMessage;
  ProductErrorState({required this.errorMessage});
}

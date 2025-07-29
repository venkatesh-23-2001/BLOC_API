import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_form/model/product_model.dart';

class ApiRepository {
  Future<List<ProductModel>> getProductList() async {
    String url = "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final bodyData = jsonDecode(response.body);
      print('API DATA ::: ${bodyData}');
      return (bodyData as List).map((e) => ProductModel.fromJson(e)).toList();
    } else {
      print('API FETCH ERROR .....');
      return throw Exception('Failed to get Products');
    }
  }
}

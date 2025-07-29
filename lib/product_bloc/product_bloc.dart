import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_form/product_bloc/product_event.dart';
import 'package:test_form/product_bloc/product_state.dart';
import 'package:test_form/repository/api_repository.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   late ApiRepository apiRepository;
//   ProductBloc(this.apiRepository) : super(ProductInitialState()) {
//     on<GetProductDetails>(event,emit) async {
//       emit(ProductLoadingState());
//       try{
//         final response = await apiRepository.getProductList();
//         emit(ProductSuccessState(
//             successMessage: "Product Fetched",
//             productList: response,),);
//       }catch(e){
//         emit(ProductErrorState(errorMessage: "Product Fetch Failed"));
//       }
//     }
// }

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState());

  Future<void> getProducts() async {
    try {
      emit(ProductLoadingState());
      final response = await ApiRepository().getProductList();
      emit(ProductSuccessState(successMessage: "Product Fetched", productList: response));
    } catch (error) {
      print("CACHE ERROR :::: ${error.toString()}");
      emit(ProductErrorState(errorMessage: "Product Fetch Failed"));
    }
  }
}

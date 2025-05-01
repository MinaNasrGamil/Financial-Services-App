import 'package:equatable/equatable.dart';
import 'package:finance_app/constants/enums/status_enum.dart';
import 'package:finance_app/data/models/product.dart';
import 'package:finance_app/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  ProductCubit(this.repository) : super(ProductState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: StatusEnum.loading));
    try {
      final products = await repository.fetchProducts();
      emit(state.copyWith(status: StatusEnum.success, products: products));
    } catch (e) {
      emit(
          state.copyWith(status: StatusEnum.error, errorMessage: e.toString()));
    }
  }
}

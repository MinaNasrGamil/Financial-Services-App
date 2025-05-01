// test/product_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:finance_app/constants/enums/status_enum.dart';
import 'package:finance_app/data/models/product.dart';
import 'package:finance_app/data/repositories/product_repository.dart';
import 'package:finance_app/logic/cubits/product/product_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductCubit', () {
    late ProductCubit productCubit;

    setUp(() {
      productCubit = ProductCubit(ProductRepository());
    });

    blocTest<ProductCubit, ProductState>(
      'emits [loading, success] when loadProducts succeeds',
      build: () => ProductCubit(ProductRepository()),
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        // First state with loading status
        predicate<ProductState>((state) => state.status == StatusEnum.loading),
        // Then state with success status and non-empty products list
        predicate<ProductState>((state) =>
            state.status == StatusEnum.success &&
            state.products is List<Product> &&
            state.products.isNotEmpty),
      ],
    );
  });
}

// lib/logic/cubits/product_state.dart
part of 'product_cubit.dart';

class ProductState extends Equatable {
  final StatusEnum status;
  final List<Product> products;
  final String errorMessage;

  const ProductState({
    required this.status,
    required this.products,
    required this.errorMessage,
  });

  factory ProductState.initial() {
    return const ProductState(
      status: StatusEnum.initial,
      products: [],
      errorMessage: '',
    );
  }

  ProductState copyWith({
    StatusEnum? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}

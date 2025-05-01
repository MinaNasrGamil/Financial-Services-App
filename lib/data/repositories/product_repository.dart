import 'package:finance_app/constants/AppConstants.dart';
import 'package:finance_app/data/models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(AppConstants.apiDelay);
    return List.generate(
      5,
      (i) => Product(
        id: i,
        title: 'Product ${i + 1}',
        description:
            'Description for product ${i + 1}, Description for product ${i + 1}, Description for product ${i + 1}, Description for product ${i + 1}, Description for product ${i + 1}',
        imageUrl:
            'https://cdn.usegalileo.ai/sdxl10/03ab86a2-e856-41ce-96b4-003503f1c359.png',
      ),
    );
  }
}

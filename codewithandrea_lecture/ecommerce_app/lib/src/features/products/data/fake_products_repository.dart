import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map(
      (products) => products.firstWhere((product) => product.id == id),
    );
  }
}

final productRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productListStreamProvider = StreamProvider<List<Product>>((ref) {
  final productsRepository = ref.watch(productRepositoryProvider);
  return productsRepository.watchProductsList();
});

final productListFutureProvider = FutureProvider<List<Product>>((ref) {
  final productsRepository = ref.watch(productRepositoryProvider);
  return productsRepository.fetchProductsList();
});

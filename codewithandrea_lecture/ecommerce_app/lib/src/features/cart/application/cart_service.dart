import 'dart:math';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/domain/mutable_cart.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartService {
  CartService(this.ref);

  final Ref ref;

  Future<Cart> _fetchCart() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref.read(remoteCartRepositoryProvider).fetchCart(user.uid);
    }
    return ref.read(localCartRepositoryProvider).fetchCart();
  }

  Future<void> _setCart(Cart cart) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref.read(remoteCartRepositoryProvider).setCart(user.uid, cart);
    }
    return ref.read(localCartRepositoryProvider).setCart(cart);
  }

  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
  }

  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.addItem(item);
    await _setCart(updated);
  }

  Future<void> removeItemById(ProductID productId) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productId);
    await _setCart(updated);
  }
}

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(ref);
});

final cartProvider = StreamProvider<Cart>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(remoteCartRepositoryProvider).watchCart(user.uid);
  }
  return ref.watch(localCartRepositoryProvider).watchCart();
});

final cartItemsProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).maybeMap(
        data: (cart) => cart.value.items.length,
        orElse: () => 0,
      );
});

final cartTotalProvider = Provider.autoDispose<double>((ref) {
  final cart = ref.watch(cartProvider).value ?? const Cart();
  final productsList = ref.watch(productsListStreamProvider).value ?? [];
  if (cart.items.isNotEmpty && productsList.isNotEmpty) {
    /*
    var total = 0.0;
    for (final item in cart.items.entries) {
      final product =
          productsList.firstWhere((product) => product.id == item.key);
      total += product.price * item.value;
    }
    return total;
    */
    // reduce
    return cart.items.entries.map((item) {
      final product =
          productsList.firstWhere((product) => product.id == item.key);
      return product.price * item.value;
    }).reduce((value, itemPrice) => value + itemPrice);
  } else {
    return 0.0;
  }
});

final itemAvailableQuantityProvider =
    Provider.autoDispose.family<int, Product>((ref, product) {
  final cart = ref.watch(cartProvider).value;
  if (cart != null) {
    final quantity = cart.items[product.id] ?? 0;
    return max(0, product.availableQuantity - quantity);
  }
  return product.availableQuantity;
});

import 'dart:math';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/domain/mutable_cart.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartSyncService {
  CartSyncService(this.ref) {
    _init();
  }

  final Ref ref;

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) {
      final previousUser = previous?.value;
      final user = next.value;
      if (previousUser == null && user != null) {
        _moveItemsToRemoteCart(user.uid);
      }
    });
  }

  Future<void> _moveItemsToRemoteCart(String uid) async {
    try {
      // get the local cart data
      final localCartRepository = ref.read(localCartRepositoryProvider);
      final localCart = await localCartRepository.fetchCart();
      // localCart -> remoteCart
      if (localCart.items.isNotEmpty) {
        // get the remote cart data
        final remoteCartRepository = ref.read(remoteCartRepositoryProvider);
        final remoteCart = await remoteCartRepository.fetchCart(uid);
        final localItemsToAdd =
            await _getLocalItemsToAdd(localCart, remoteCart);
        // local 카트에 있는 아이템 > remote cart로 이전
        final updatedRemoteCart = remoteCart.addItems(localItemsToAdd);
        await remoteCartRepository.setCart(uid, updatedRemoteCart);
        // local cart 아이템 삭제
        await localCartRepository.setCart(const Cart());
      }
    } catch (e) {
      // todo: handle error
    }
  }

  Future<List<Item>> _getLocalItemsToAdd(
      Cart localCart, Cart remoteCart) async {
    final productsRepository = ref.read(productsRepositoryProvider);
    final products = await productsRepository.fetchProductsList();
    final localItemsToAdd = <Item>[];

    for (final localItem in localCart.items.entries) {
      final productId = localItem.key;
      final localQuantity = localItem.value;
      final remoteQuantity = remoteCart.items[productId] ?? 0;
      final product = products.firstWhere((product) => product.id == productId);
      final cappedLocalQuantity = min(
        localQuantity,
        product.availableQuantity - remoteQuantity,
      );
      if (cappedLocalQuantity > 0) {
        localItemsToAdd.add(Item(
          productId: productId,
          quantity: cappedLocalQuantity,
        ));
      }
    }
    return localItemsToAdd;
  }
}

final cartSyncServiceProvider = Provider<CartSyncService>((ref) {
  return CartSyncService(ref);
});

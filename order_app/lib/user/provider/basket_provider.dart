import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/product/model/product_model.dart';
import 'package:order_app/user/model/basket_item_model.dart';

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    final exists =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;
    if (exists) {
      // 만일 이미 들어있다면
      // 장바구니에 있는 값에 + 1 을 해준다.
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    } else {
      // 아직 장바구니에 해당되는 상품이 없다면
      // 장바구니에 상품을 추가한다.
      state = [...state, BasketItemModel(product: product, count: 1)];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    // true 면 count 와 관계없이 삭제
    bool isDelete = false,
  }) async {
    // 장바구니의 상품이 존재할때
    final exists =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;
    // 상품이 존재하지 않으면 바로 리턴
    if (!exists) {
      return;
    }

    final existingProduct =
        state.firstWhere((element) => element.product.id == product.id);
    // 상품의 카운트가 1이면 삭제
    if (existingProduct.count == 1 || isDelete) {
      state = state
          .where(
            (element) => element.product.id != product.id,
          )
          .toList();
    } else {
      // 상품의 카운트가 1보다 크면 -1
      state = state
          .map((e) => e.product.id == product.id
              ? e.copyWith(
                  count: e.count - 1,
                )
              : e)
          .toList();
    }
  }
}

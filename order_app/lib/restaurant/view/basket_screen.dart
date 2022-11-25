import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/common/const/colors.dart';
import 'package:order_app/common/layout/default_layout.dart';
import 'package:order_app/user/provider/basket_provider.dart';

import '../../product/component/product_card.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => 'basket';

  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvier);

    if (basket.isEmpty) {
      return const DefaultLayout(
        title: '장바구니',
        child: Center(
          child: Text('장바구니가 비어있습니다.'),
        ),
      );
    }

    final productsTotal =
        basket.fold<int>(0, (p, n) => p + (n.product.price * n.count));
    final deliveryFee = basket.first.product.restaurant.deliveryFee;

    return DefaultLayout(
      title: '장바구니',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const Divider(height: 32);
                  },
                  itemBuilder: (_, index) {
                    final model = basket[index];
                    return ProductCard.fromProductModel(
                      model: model.product,
                      onAdd: () {
                        ref.read(basketProvier.notifier).addToBasket(
                              product: model.product,
                            );
                      },
                      onSubtract: () {
                        ref.read(basketProvier.notifier).removeFromBasket(
                              product: model.product,
                            );
                      },
                    );
                  },
                  itemCount: basket.length,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '장바구니 금액',
                        style: TextStyle(color: BODY_TEXT_COLOR),
                      ),
                      Text(
                        productsTotal.toString(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '배달비',
                        style: TextStyle(color: BODY_TEXT_COLOR),
                      ),
                      if (basket.isNotEmpty) Text(deliveryFee.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '총액',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text((deliveryFee + productsTotal).toString()),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
                      child: const Text('결제하기'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

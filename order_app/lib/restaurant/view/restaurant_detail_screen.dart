import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/common/layout/default_layout.dart';
import 'package:order_app/product/component/product_card.dart';
import 'package:order_app/restaurant/component/restaurant_card.dart';
import 'package:order_app/restaurant/model/restaurant_detail_model.dart';
import 'package:order_app/restaurant/provider/restaurant_provider.dart';
import 'package:order_app/restaurant/repository/restaurant_repository.dart';

import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(restaurantDetailProvider(id));

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(model: state),
          // renderLabel(),
          // renderProducts(products: snapshot.data!.products),
        ],
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}

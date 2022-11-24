import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_app/common/components/pagination_list_view.dart';
import 'package:order_app/product/model/product_model.dart';
import 'package:order_app/product/provider/product_provider.dart';
import 'package:order_app/restaurant/view/restaurant_detail_screen.dart';

import '../component/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(
              RestaurantDetailScreen.routeName,
              params: {'rid': model.id},
            );
          },
          child: ProductCard.fromProductModel(model: model),
        );
      },
    );
  }
}

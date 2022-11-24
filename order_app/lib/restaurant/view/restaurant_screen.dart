import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_app/common/components/pagination_list_view.dart';
import 'package:order_app/restaurant/provider/restaurant_provider.dart';
import 'package:order_app/restaurant/view/restaurant_detail_screen.dart';

import '../component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(
              RestaurantDetailScreen.routeName,
              params: {'rid': model.id},
            );
          },
          child: RestaurantCard.fromModel(model: model),
        );
      },
    );
  }
}

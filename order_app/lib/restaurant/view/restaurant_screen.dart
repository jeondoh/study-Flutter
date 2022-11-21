import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/common/model/cursor_pagination_model.dart';
import 'package:order_app/restaurant/model/restaurant_model.dart';
import 'package:order_app/restaurant/repository/restaurant_repository.dart';

import '../component/restaurant_card.dart';
import 'restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<CursorPagination<RestaurantModel>>(
          future: ref.watch(restaurantRepositoryProvider).paginate(),
          builder: (context,
              AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              itemCount: snapshot.data!.data.length,
              itemBuilder: (_, index) {
                final pItem = snapshot.data!.data[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailScreen(
                          id: pItem.id,
                        ),
                      ),
                    );
                  },
                  child: RestaurantCard.fromModel(model: pItem),
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox(height: 16.0);
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:order_app/restaurant/model/restaurant_model.dart';

import '../../common/const/data.dart';
import '../component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final item = snapshot.data![index];
                final pItem = RestaurantModel(
                  id: item['id'],
                  name: item['name'],
                  thumbUrl: 'http://$ip${item['thumbUrl']}',
                  tags: List<String>.from(item['tags']),
                  priceRange: RestaurantPriceRange.values.firstWhere(
                    (element) => element.name == item['priceRange'],
                  ),
                  ratings: item['ratings'],
                  ratingsCount: item['ratingsCount'],
                  deliveryTime: item['deliveryTime'],
                  deliveryFee: item['deliveryFee'],
                );

                return RestaurantCard(
                  image: Image.network(
                    pItem.thumbUrl,
                    fit: BoxFit.cover,
                  ),
                  name: pItem.name,
                  tags: pItem.tags,
                  ratingsCount: pItem.ratingsCount,
                  deliveryTime: pItem.deliveryTime,
                  deliveryFee: pItem.deliveryFee,
                  ratings: pItem.ratings,
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

import 'package:dio/dio.dart' hide Headers;
import 'package:order_app/common/model/cursor_pagination_model.dart';
import 'package:order_app/restaurant/model/restaurant_detail_model.dart';
import 'package:order_app/restaurant/model/restaurant_model.dart';
import 'package:retrofit/http.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/common/model/cursor_pagination_model.dart';
import 'package:order_app/common/provider/pagination_provider.dart';
import 'package:order_app/restaurant/model/restaurant_model.dart';
import 'package:order_app/restaurant/repository/restaurant_repository.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }
  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({required super.repository});

  void getDetail({
    required String id,
  }) async {
    // 만일 아직 데이터가 하나도 없는 상태 (CursorPagination 아니라면)
    // 데이터를 가져오는 시도를 함
    if (state is! CursorPagination) {
      await paginate();
    }
    // state 가 CursorPagination 이 아닐때 null 반환
    if (state is! CursorPagination) {
      return;
    }
    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(id: id);

    // 데이터가 없는 경우에는 캐시 끝에 데이터를 추가해버림
    // ex) 리스트에서 id가 4번까지 있는데, 10번의 데이터를 요청하는 경우
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(data: <RestaurantModel>[
        ...pState.data,
        resp,
      ]);
    } else {
      // 이미 존재하는 데이터 가져오기
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? resp : e)
            .toList(),
      );
    }
  }
}

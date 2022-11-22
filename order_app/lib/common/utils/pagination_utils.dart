import 'package:flutter/material.dart';

import '../provider/pagination_provider.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    // 현재 위치가 최대 길이보다 조금 덜되는 위치까지 왔다면
    // 새로운 데이터 추가요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(fetchMore: true);
    }
  }
}

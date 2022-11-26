import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/order/model/post_order_body.dart';
import 'package:uuid/uuid.dart';

import '../../user/provider/basket_provider.dart';
import '../model/order_model.dart';
import '../repository/order_repository.dart';

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrderModel>>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrderStateNotifier(ref: ref, repository: repository);
});

class OrderStateNotifier extends StateNotifier<List<OrderModel>> {
  final Ref ref;
  final OrderRepository repository;

  OrderStateNotifier({
    required this.ref,
    required this.repository,
  }) : super([]);

  Future<bool> postOrder() async {
    try {
      const uuid = Uuid();
      final id = uuid.v4();
      final state = ref.read(basketProvider);
      final resp = await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map((e) => PostOrderBodyProduct(e.product.id, e.count))
              .toList(),
          totalPrice: state.fold(0, (p, n) => p + (n.count * n.product.price)),
          createdAt: DateTime.now().toString(),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

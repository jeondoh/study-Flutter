import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/application/reviews_service.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/utils/current_date_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveReviewController extends StateNotifier<AsyncValue<void>> {
  LeaveReviewController({
    required this.reviewsService,
    required this.currentDateBuilder,
  }) : super(const AsyncData(null));

  final ReviewsService reviewsService;
  final DateTime Function() currentDateBuilder;

  // BuildContext 는 인수로 전달 X
  // 함수를 선언해서 함수를 전달받게 하고, 함수 구현부에 context사용
  Future<void> submitReview({
    Review? previousReview,
    required ProductID productId,
    required double rating,
    required String comment,
    required void Function() onSuccess,
  }) async {
    if (previousReview == null ||
        rating != previousReview.rating ||
        comment != previousReview.comment) {
      final review = Review(
        rating: rating,
        comment: comment,
        date: currentDateBuilder(),
      );
      state = const AsyncLoading();
      final newState = await AsyncValue.guard(
        () => reviewsService.submitReview(productId: productId, review: review),
      );
      if (mounted) {
        state = newState;
        if (state.hasError == false) {
          onSuccess();
        }
      }
    } else {
      onSuccess();
    }
  }
}

final leaveReviewControllerProvider =
    StateNotifierProvider.autoDispose<LeaveReviewController, AsyncValue<void>>(
        (ref) {
  return LeaveReviewController(
    reviewsService: ref.watch(reviewsServiceProvider),
    currentDateBuilder: ref.watch(currentDateBuilderProvider),
  );
});

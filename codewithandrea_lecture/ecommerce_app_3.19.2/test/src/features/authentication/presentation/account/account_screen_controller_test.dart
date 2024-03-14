import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group("accountScreenController", () {
    test('initial state is AsyncValue.data', () {
      final authRepository = MockAuthRepository();
      final controller = AccountScreenController(
        authRepository: authRepository,
      );
      verifyNever(authRepository.signOut);
      // AsyncValue.data = AsyncData
      expect(controller.state, const AsyncValue.data(null));
    });
  });

  test('signOut success', () async {
    final authRepository = MockAuthRepository();
    // when(() => authRepository.signOut());
    when(authRepository.signOut).thenAnswer(
      (_) => Future.value(),
    );
    final controller = AccountScreenController(
      authRepository: authRepository,
    );
    await controller.signOut();
    verify(authRepository.signOut).called(1);
    expect(controller.state, const AsyncData<void>(null));
  });

  test('signOut failure', () async {
    final authRepository = MockAuthRepository();
    final exception = Exception("connection failed");
    when(authRepository.signOut).thenThrow(exception);
    final controller = AccountScreenController(
      authRepository: authRepository,
    );
    await controller.signOut();
    verify(authRepository.signOut).called(1);
    expect(controller.debugState.hasError, true);
    // expect(controller.debugState, isA<AsyncError>());
  });
}

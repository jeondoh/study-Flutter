import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AsyncError 전역 트래킹
class AsyncErrorLogger extends ProviderObserver {
  // didUpdateProvider = provider가 알림을 내보낼 때마다 호출
  // 내부 상태 변경 추적에 사용
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final error = _findError(newValue);
    if (error != null) {
      if (error.error is AppException) {
        // only prints the AppException data
        debugPrint(error.error.toString());
      } else {
        // print everything including the stack trace
        debugPrint(error.toString());
      }
    }
  }

  AsyncError<dynamic>? _findError(Object? value) {
    if (value is EmailPasswordSignInState && value.value is AsyncError) {
      return value.value as AsyncError;
    } else if (value is AsyncError) {
      return value;
    } else {
      return null;
    }
  }
}

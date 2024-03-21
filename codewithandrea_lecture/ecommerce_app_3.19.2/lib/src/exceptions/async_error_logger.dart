import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/exceptions/error_logger.dart';
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
    final errorLogger = container.read(errorLoggerProvider);
    final error = _findError(newValue);
    if (error != null) {
      if (error.error is AppException) {
        // only prints the AppException data
        errorLogger.logAppException(error.error as AppException);
      } else {
        // print everything including the stack trace
        errorLogger.logError(error.error, error.stackTrace);
      }
    }
  }

  AsyncError<dynamic>? _findError(Object? value) {
    if (value is AsyncError) {
      return value;
    } else {
      return null;
    }
  }
}

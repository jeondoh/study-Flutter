import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);

    print(
        '[Provider Updated] provider: $provider / pv: $previousValue / nv: $newValue');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    super.didAddProvider(provider, value, container);
    print('[Provider Added] provider: $provider / pv: $value');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    super.didDisposeProvider(provider, container);
    print('[Provider Disposed] provider: $provider');
  }
}

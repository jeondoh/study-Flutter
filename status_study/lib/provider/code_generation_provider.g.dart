// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_generation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $GStateNotifierHash() => r'f5d3562260bad49518ffe5b82e60b7cc1b8655f2';

/// See also [GStateNotifier].
final gStateNotifierProvider = AutoDisposeNotifierProvider<GStateNotifier, int>(
  GStateNotifier.new,
  name: r'gStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $GStateNotifierHash,
);
typedef GStateNotifierRef = AutoDisposeNotifierProviderRef<int>;

abstract class _$GStateNotifier extends AutoDisposeNotifier<int> {
  @override
  int build();
}

String $gStateHash() => r'9faaf0f2909ca4390ff19fa63e976aa41c7431e1';

/// See also [gState].
final gStateProvider = AutoDisposeProvider<String>(
  gState,
  name: r'gStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $gStateHash,
);
typedef GStateRef = AutoDisposeProviderRef<String>;
String $gStateFutureHash() => r'eef3e95f799e15b4647a3851f8ee6b4438b05afa';

/// See also [gStateFuture].
final gStateFutureProvider = AutoDisposeFutureProvider<int>(
  gStateFuture,
  name: r'gStateFutureProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $gStateFutureHash,
);
typedef GStateFutureRef = AutoDisposeFutureProviderRef<int>;
String $gStateFuture2Hash() => r'c346965a30436f2ab0f038c27592f51d26b2d4bb';

/// See also [gStateFuture2].
final gStateFuture2Provider = FutureProvider<int>(
  gStateFuture2,
  name: r'gStateFuture2Provider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $gStateFuture2Hash,
);
typedef GStateFuture2Ref = FutureProviderRef<int>;
String $gStateMultiplyHash() => r'ec5a8efb6ba3e90e29f7a0722867976890c2a634';

/// See also [gStateMultiply].
class GStateMultiplyProvider extends AutoDisposeProvider<int> {
  GStateMultiplyProvider({
    required this.number1,
    required this.number2,
  }) : super(
          (ref) => gStateMultiply(
            ref,
            number1: number1,
            number2: number2,
          ),
          from: gStateMultiplyProvider,
          name: r'gStateMultiplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $gStateMultiplyHash,
        );

  final int number1;
  final int number2;

  @override
  bool operator ==(Object other) {
    return other is GStateMultiplyProvider &&
        other.number1 == number1 &&
        other.number2 == number2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number1.hashCode);
    hash = _SystemHash.combine(hash, number2.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GStateMultiplyRef = AutoDisposeProviderRef<int>;

/// See also [gStateMultiply].
final gStateMultiplyProvider = GStateMultiplyFamily();

class GStateMultiplyFamily extends Family<int> {
  GStateMultiplyFamily();

  GStateMultiplyProvider call({
    required int number1,
    required int number2,
  }) {
    return GStateMultiplyProvider(
      number1: number1,
      number2: number2,
    );
  }

  @override
  AutoDisposeProvider<int> getProviderOverride(
    covariant GStateMultiplyProvider provider,
  ) {
    return call(
      number1: provider.number1,
      number2: provider.number2,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'gStateMultiplyProvider';
}

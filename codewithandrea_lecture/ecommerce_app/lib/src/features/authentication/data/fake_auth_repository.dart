import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthRepository extends AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() {
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  AppUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}

class FakeAuthRepository extends AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;
  @override
  AppUser? get currentUser => _authState.value;
  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  void dispose() => _authState.close();

  void _createNewUser(String email) {
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});

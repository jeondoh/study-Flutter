import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:order_app/common/view/root_tab.dart';
import 'package:order_app/common/view/splash_screen.dart';
import 'package:order_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:order_app/user/model/user_model.dart';
import 'package:order_app/user/provider/user_me_provider.dart';
import 'package:order_app/user/view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) => RestaurantDetailScreen(
                id: state.params['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
      ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  // splashScreen 앱 처음 시작시 토큰이 존재하는지 확인
  // 로그인 스크린으로 보낼지, 홈 스크린으로 보낼지 확인 과정 필요
  Future<String?> redirectLogic(
      BuildContext context, GoRouterState state) async {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    // 유저 정보가 없는데 로그인중이라면 그대로 로그인 페이지 유지
    // 만약 로그인중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // user 가 null 이 아님
    // UserModel
    // 사용자 정보가 있는 상태면 로그인 중이거나 현재 위치가 SplashScreen 이면
    // 홈으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    // UserModelError
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}

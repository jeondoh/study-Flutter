import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:order_app/common/view/root_tab.dart';
import 'package:order_app/common/view/splash_screen.dart';
import 'package:order_app/restaurant/view/basket_screen.dart';
import 'package:order_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:order_app/user/model/user_model.dart';
import 'package:order_app/user/provider/user_me_provider.dart';
import 'package:order_app/user/view/login_screen.dart';

import '../../order/view/order_done_screen.dart';

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
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (_, state) => const BasketScreen(),
        ),
        GoRoute(
          path: '/order_done',
          name: OrderDoneScreen.routeName,
          builder: (_, state) => const OrderDoneScreen(),
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

  // splashScreen ??? ?????? ????????? ????????? ??????????????? ??????
  // ????????? ??????????????? ?????????, ??? ??????????????? ????????? ?????? ?????? ??????
  Future<String?> redirectLogic(
      BuildContext context, GoRouterState state) async {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    // ?????? ????????? ????????? ????????????????????? ????????? ????????? ????????? ??????
    // ?????? ??????????????? ???????????? ????????? ???????????? ??????
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // user ??? null ??? ??????
    // UserModel
    // ????????? ????????? ?????? ????????? ????????? ???????????? ?????? ????????? SplashScreen ??????
    // ????????? ??????
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

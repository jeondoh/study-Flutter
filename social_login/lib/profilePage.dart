import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:social_login/LoginController.dart';

import 'UserStruct.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Future<void> _handleGoogleSignIn() async {
    await _controller.setGoogleSignIn();
  }

  Future<void> _handleAppleSignIn() async {
    await _controller.setAppleSignIn();
  }

  Future<void> _handleSignOut() async {
    await _controller.signOut();
  }

  Widget _buildBody() {
    return Center(
      child: GetBuilder<LoginController>(
        builder: (_) {
          UserStruct user = _controller.getUser;
          print(user);
          if (user.getSocial == -1) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("애플은 ★소중★하니까"),
                const Text("로고 박음"),
                SignInWithAppleButton(
                  onPressed: _handleAppleSignIn,
                ),
                ElevatedButton(
                  onPressed: _handleGoogleSignIn,
                  child: const Text('구으글 로그인'),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.getEmail),
                Text(user.getAuthCode ?? ''),
                const Text('★ 판돈 1000만원 획득 ★'),
                ElevatedButton(
                  onPressed: _handleSignOut,
                  child: const Text('SIGN OUT'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

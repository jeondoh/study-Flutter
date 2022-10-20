import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login/LoginController.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Future<void> _handleSignIn() async {
    try {
      await _controller.getGoogleSinIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    await _controller.getGoogleSinIn.signOut();
    // await _controller.getGoogleSinIn.disconnect();
  }

  Widget _buildBody() {
    return Center(
      child: GetBuilder<LoginController>(
        builder: (_) {
          GoogleSignInAccount? user = _controller.getCurrentUser;
          if (user == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("★판돈 가져오기★"),
                ElevatedButton(
                  onPressed: _handleSignIn,
                  child: const Text('구우글 로그인'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('앺플 로그인'),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: GoogleUserCircleAvatar(
                    identity: user,
                  ),
                  title: Text(user.displayName ?? ''),
                  subtitle: Text(user.email),
                ),
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

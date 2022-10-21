import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'UserStruct.dart';

class LoginController extends GetxController {
  final UserStruct _user = UserStruct();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> setGoogleSignIn() async {
    final GoogleSignInAccount currentUser =
        await _googleSignIn.signIn() as GoogleSignInAccount;
    _user.setUserEmail(currentUser.email ?? '');
    _user.setSocialType('android');
    print(_user.toString());
    update();
  }

  Future<void> setAppleSignIn() async {
    AuthorizationCredentialAppleID appleSingIn =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
      ],
    );
    // 최초 로그인이 아닐시에 이메일은 빈값으로 넘어옴
    _user.setUserEmail(appleSingIn.email ?? '');
    _user.setUserAuthCode(appleSingIn.authorizationCode ?? '');
    _user.setSocialType('apple');
    update();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _user.initUserData();
    // setdeviceid
    update();
  }

  get getUser => _user;
}

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // serverClientId:
    //     '1067764577527-5rvp4o4or3pjlhg8iuhoeu8vpnphqni8.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount? _currentUser;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      update();
      print(account);
    });
    _googleSignIn.signInSilently();
  }

  void setGoogleAccount(GoogleSignInAccount account) {
    _currentUser = account;
    update();
  }

  get getGoogleSinIn => _googleSignIn;
  get getCurrentUser => _currentUser;
}

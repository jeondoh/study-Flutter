class UserStruct {
  String? _email;
  String? _deviceId;
  String? _authorizationCode;
  String? _walletAddr;
  int? _socialType;

  UserStruct({
    String? email = '',
    String? deviceId = '',
    String? authorizationCode = '',
    String? walletAddr = '',
    int? socialType = -1,
  })  : _email = email,
        _deviceId = deviceId,
        _authorizationCode = authorizationCode,
        _walletAddr = walletAddr,
        _socialType = socialType;

  void setUserEmail(String email) => _email = email;
  void setUserAuthCode(String authCode) => _authorizationCode = authCode;
  void setSocialType(String social) {
    if (social == "apple") {
      _socialType = 0;
      return;
    } else if (social == "android") {
      _socialType = 1;
      return;
    }
    _socialType = -1;
  }

  void initUserData() {
    _email = '';
    _deviceId = '';
    _authorizationCode = '';
    _walletAddr = '';
    _socialType = -1;
  }

  String getSocialTypeToString(int socialType) {
    if (socialType == 0) {
      return "android";
    } else if (socialType == 1) {
      return "apple";
    }
    return "none";
  }

  get getEmail => _email;
  get getSocial => _socialType;
  get getAuthCode => _authorizationCode;

  @override
  String toString() {
    String socialType = getSocialTypeToString(_socialType!);
    return 'email : $_email, deviceId : $_deviceId, authorizationCode : $_authorizationCode, walletAddress : $_walletAddr, socialType : $socialType';
  }
}

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// import 'package:flutterpress/controllers/flutterbase.controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase Auth Service
///
/// This class handles `Firebase User Login`.
///
///
///
class FlutterbaseAuthService {
  // final FlutterbaseController _controller = Get.find();

  /// Firebase Auth
  ///
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //////////////////////////////////////////////////////////////////////////////
  ///
  /// Apple Sign in
  ///

  /// Determine if Apple SignIn is available.
  /// Android may not provide Apple Sign In.
  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  /// Sign in with Apple
  Future<User> loginWithAppleAccount() async {
    try {
      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        print('Got apple login error:');
        print(appleResult.error);
        throw appleResult.error.code;
      }

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken:
            String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      UserCredential firebaseResult =
          await _auth.signInWithCredential(credential);
      User user = firebaseResult.user;

      // Optional, Update user data in Firestore
      // updateUserData(user);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  ///
  /// Google Sign in
  ///
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Login with Google account.
  ///
  /// @note If the user cancels, then `null` is returned
  Future<User> loginWithGoogleAccount() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);

      final User user = authResult.user;

      print("signed in " + user.displayName);
      print(user);

      // saveOrUpdateFirebaseUser(user);

      /// 파이어베이스에서 이미 로그인을 했으므로, GoogleSignIn 에서는 바로 로그아웃을 한다.
      /// GoogleSignIn 에서 로그아웃을 안하면, 다음에 로그인을 할 때, 다른 계정으로 로그인을 못한다.
      /// Logout immediately from `Google` so, the user can choose another
      /// Google account on next login.
      await _googleSignIn.signOut();

      return user;
    } on PlatformException catch (e) {
      await onPlatformException(e);
      // print('ecode: ${e.code}');
      // final code = e.code.toLowerCase();
      // throw code;
    } catch (e) {
      // print('loginWithGoogleAccount::');
      // print(e);
      // throw e.message;
      throw e;
    }
    return null;
  }


  //////////////////////////////////////////////////////////////////////////////
  ///
  /// Kakaotalk Login
  /// 카카오톡 로그인
  ///
  // Future<FirebaseUser> loginWithKakaotalkAccount() async {
  //   KakaoContext.clientId = _controller.kakaotalkClientId;
  //   KakaoContext.javascriptClientId = _controller.kakaotalkJavascriptClientId;

  //   /// 카카오톡 로그인을 경우, 상황에 따라 메일 주소가 없을 수 있다. 메일 주소가 필수 항목이 아닌 경우,
  //   /// 따라서, id 로 메일 주소를 만들어서, 자동 회원 가입을 한다.
  //   ///
  //   try {
  //     /// 카카오톡 앱이 핸드폰에 설치되었는가?
  //     /// See if kakaotalk is installed on the phone.
  //     final installed = await isKakaoTalkInstalled();

  //     /// login with kakaotalk.
  //     /// - If Kakotalk app is installed, then login with the Kakaotalk App.
  //     /// - Otherwise, login with webview.
  //     /// 카카오톡 앱이 설치 되었으면, 앱으로 로그인, 아니면 OAuth 로 로그인.
  //     final authCode = installed
  //         ? await AuthCodeClient.instance.requestWithTalk()
  //         : await AuthCodeClient.instance.request();

  //     AccessTokenResponse token =
  //         await AuthApi.instance.issueAccessToken(authCode);

  //     /// Store access token in AccessTokenStore for future API requests.
  //     /// 이걸 해야지, 아래에서 UserApi.instance.me() 와 같이 호출을 할 수 있나??
  //     AccessTokenStore.instance.toStore(token);

  //     ////
  //     String refreshedToken = token.refreshToken;
  //     print('----> refreshedToken: $refreshedToken');

  //     /// Get Kakaotalk user info
  //     kakao.User user = await kakao.UserApi.instance.me();
  //     print(user.properties);
  //     Map<String, String> data = {
  //       'email': 'kakaotalk${user.id}@kakao.com',
  //       'password': 'Settings.secretKey+${user.id}',
  //       'displayName': user.properties['nickname'],
  //       'photoUrl': user.properties['profile_image'],
  //     };

  //     print('----> kakaotalk login success: $data');

  //     /// login or register.
  //     return loginOrRegister(data);
  //     // _controller.update(['user']);

  //   } on KakaoAuthException catch (e) {
  //     throw e;
  //   } on KakaoClientException catch (e) {
  //     throw e;
  //   } catch (e) {
  //     /// 카카오톡 로그인에서 에러가 발생하는 경우,
  //     /// 에러 메시지가 로그인 창에 표시가 되므로, 상단 위젯에서는 에러를 무시를 해도 된다.
  //     /// 예를 들어, 비밀번호 오류나, 로그인 취소 등.
  //     print('error: =====> ');
  //     print(e);
  //     throw e;
  //   }
  // }

  /// Display `ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL` in snackbar.
  /// Other errors will be thrown to parent.
  onPlatformException(e) async {
    print('onPlatformException():');
    print(e.code);
    if (e.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
      Get.snackbar('중복 소셜 로그인',
          '동일한 메일 주소의 다른 소셜 아이디로 이미 로그인되어져 있습니다. 다른 소셜아이디로 로그인을 하세요.',
          duration: Duration(seconds: 10));
    }
    print(e);
    throw e;
  }
}

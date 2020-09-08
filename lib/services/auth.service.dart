
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutterpress/controllers/flutterbase.controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase Auth Service
///
/// This class handles `Firebase User Login`.
///
///
///
class FlutterbaseAuthService {
  final FlutterbaseController _controller = Get.find();

  /// Firebase Auth
  ///

  ///
  final FirebaseAuth _auth = FirebaseAuth.instance;



  //////////////////////////////////////////////////////////////////////////////
  ///
  ///
  /// Google Sign in
  ///
  ///

  //////////////////////////////////////////////////////////////////////////////
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Login with Google account.
  ///
  /// @note If the user cancels, then `null` is returned
  Future<FirebaseUser> loginWithGoogleAccount() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
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
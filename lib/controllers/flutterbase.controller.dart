import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class FlutterbaseController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// FirebaseUser
  ///
  /// - `auth.currentUser()` is `Future` function.
  /// - FirebaseUser will be updated on `onAuthStateChanged`
  ///
  /// - `user` will be `Anonymouse` if the user didn't login.
  /// - `user` must be changed by `onAuthStateChanged` only.
  ///   To handle user login.obs
  ///   When user logs out or didn't logged in, the user will login as `Anonymouse` by `onAuthStateChagned`
  User user;
  // FirebaseUser get user => _user;

  FlutterbaseController({
    this.facebookAppId,
    this.facebookRedirectUrl,
    this.kakaotalkClientId,
    this.kakaotalkJavascriptClientId,
  }) {
    _initAuthChange();
  }

  String kakaotalkClientId;
  String kakaotalkJavascriptClientId;
  int facebookAppId;
  String facebookRedirectUrl;
  // setLoginForFacebook({@required int appId, @required String redirectUrl}) {
  //   facebookAppId = appId;
  //   facebookRedirectUrl = redirectUrl;
  // }

  /// When user logged in, it return true.
  ///
  /// @note if the user logged in as `Anonymous`, then it return false.
  ///
  bool get loggedIn {
    return user != null && user.isAnonymous == false;
  }

  /// Return true when user didn't logged in.
  bool get notLoggedIn {
    return loggedIn == false;
  }

  _initAuthChange() async {
    _auth.authStateChanges().listen(
      (User u) async {
        print(u);
        user = u;
        if (u == null) {
          // print('EngineModel::onAuthStateChanged() user logged out');
          _auth.signInAnonymously();
        } else {
          // print('EngineModel::onAuthStateChanged() user logged in: $u');
          // print(
          //     'Anonymous: ${u.isAnonymous}, uid: ${u.uid}, email: ${u.email}, displayName: ${u.displayName}');

          /// 실제 사용자로 로그인을 한 경우, Anonymous 는 제외
          if (loggedIn) {
            onLogin();
            try {
              // userDocument = await profile();
              // print('userDocument: $userDocument, email: ${user.email}');
              // notify();
              // await setUserToken();
            } catch (e) {
              print('got profile error: ');
              print(e);
              // alert(e);
            }
          } else {
            print('User has logged in anonymouse');
            print('isAnonymous: ${user.isAnonymous}');

            onLogout();

            /// 로그 아웃을 한 경우 (Anonymous 로 로그인 한 경우 포함)
            // userDocument = FlutterbaseUser();
            // notify();
          }
          // update(['user']);
          // update();
        }
        update();
      },
    );
  }

  /// This method is called when a user logs in.
  /// - The user may be logged in with Google or Facebook, Apple, or other account.
  /// - It is invoked by `onAuthStateChanged`
  onLogin() {
    // print('--> on Login');
  }

  /// - It is invoked by `onAuthStateChanged`
  onLogout() {
    print(' onLogout()');
  }

  /// User logs out
  /// - `update()` will be called by `onAuthStateChanged`
  logout() async {
    var _auth = FirebaseAuth.instance;
    await _auth.signOut();
    print(' logout()');
  }
}

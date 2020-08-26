// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutterpress/flutter_test/flutter_test.helper.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:test/test.dart';

// test by steps
//  1. Register
//  2. Logout
//  3. Login
//  4. Profile Update
//  5. Post create - pending
//  6. comment create - pending
//  7. comment delete - pending
//  8. post delete - pending
//  9. resign.

class TestUser {
  static String get email => 'berry@test.com';
  static String get password => '--00,*';
  static String get nickname => 'berry';
  static String get nickname2 => 'berry2';
}

void main() {
  group('Page Checkup: ', () {
    FlutterDriver driver;
    TestHelper helper;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      helper = TestHelper(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Home Screen', () async {
      // await driver.runUnsynchronized(() async {
      var scaffold = find.byValueKey(AppKeys.homeScaffold);
      await helper.exitIfNotExists(
        scaffold,
        'Scaffold key does not exists in home screen. Or the app is not in home screen.',
      );

      var button = find.byValueKey(AppKeys.homeScaffold);
      await driver.tap(button);
      // });
    });

    test('Register', () async {
      var button = find.byValueKey(AppRoutes.register);
      await helper.exitIfNotExists(
        button,
        'Register button does not exists on home screen.',
      );
      await driver.tap(button);
      var scaffold = find.byValueKey(AppKeys.registerScaffold);
      await helper.exitIfNotExists(
        scaffold,
        'Scaffold key not exists in Register screen.',
      );

      var emailInput = find.byValueKey(AppKeys.emailInput);
      await driver.tap(emailInput);
      await driver.enterText(TestUser.email);

      var passInput = find.byValueKey(AppKeys.passwordInput);
      await driver.tap(passInput);
      await driver.enterText(TestUser.password);

      var nicknameInput = find.byValueKey(AppKeys.nicknameInput);
      await driver.tap(nicknameInput);
      await driver.enterText(TestUser.nickname);

      var submitButton = find.byValueKey(AppKeys.formSubmitButton);
      await driver.tap(submitButton);
    });

    test('Logout', () async {
      await driver.waitFor(find.byValueKey(AppKeys.homeScaffold));
      var button = find.byValueKey(AppKeys.logoutButton);
      await helper.exitIfNotExists(
        button,
        'Logout button does not exists on home screen.',
      );
      await driver.tap(button);
    });

    test('Login', () async {
      await driver.waitFor(find.byValueKey(AppKeys.homeScaffold));

      var button = find.byValueKey(AppRoutes.login);
      await helper.exitIfNotExists(
        button,
        'Login button does not exists on home screen.',
      );
      await driver.tap(button);
      var scaffold = find.byValueKey(AppKeys.loginScaffold);
      await helper.exitIfNotExists(
        scaffold,
        'Column key not exists in Login screen.',
      );

      var emailInput = find.byValueKey(AppKeys.emailInput);
      await driver.tap(emailInput);
      await driver.enterText(TestUser.email);

      var passInput = find.byValueKey(AppKeys.passwordInput);
      await driver.tap(passInput);
      await driver.enterText(TestUser.password);

      var submitButton = find.byValueKey(AppKeys.formSubmitButton);
      await driver.tap(submitButton);
    });

    test('Profile', () async {
      await driver.waitFor(find.byValueKey(AppKeys.homeScaffold));

      var button = find.byValueKey(AppRoutes.profile);
      await helper.exitIfNotExists(
        button,
        'Register button does not exists on home screen.',
      );
      await driver.tap(button);

      var scaffold = find.byValueKey(AppKeys.profileScaffold);
      await helper.exitIfNotExists(
        scaffold,
        'Scaffold key not exists in Register screen.',
      );

      var nicknameInput = find.byValueKey(AppKeys.nicknameInput);
      await driver.tap(nicknameInput);
      await driver.enterText(TestUser.nickname2);

      var submitButton = find.byValueKey(AppKeys.formSubmitButton);
      await driver.tap(submitButton);

      await delay(2000);
      await driver.tap(find.pageBack());
      await driver.tap(button);

      /// enabling this piece of code will break the test.
      /// somehow the test driver doesn't support getting text form text input field.
      ///
      /// DriverError:
      /// Error in Flutter application: Uncaught extension error while executing get_text:
      /// Unsupported operation: Type AppTextInputField is currently not supported by getText
      ///
      /// var updatedNickname = await driver.getText(nicknameInput);
      /// expect(updatedNickname, TestUser.nickname2);
    });

    // test('Post Create', () async {});

    // test('Post Update', () async {});

    // test('Comment Create', () async {});

    // test('Comment Update', () async {});

    // test('Comment Delete', () async {});

    // test('Post Delete', () async {});

    test('Resign', () async {
      var resignButton = find.byValueKey(AppKeys.resignButton);
      await driver.tap(resignButton);

      var confirmButton = find.byValueKey(AppKeys.dialogConfirmButton);
      await driver.tap(confirmButton);

      await driver.waitFor(find.byValueKey(AppKeys.homeScaffold));

      await helper.isNotPresent(find.byValueKey(AppRoutes.profile));
    });
  });
}

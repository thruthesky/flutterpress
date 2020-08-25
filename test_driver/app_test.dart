// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutterpress/flutter_test/flutter_test.helper.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:test/test.dart';

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
      await delay(1000);
      // await driver.runUnsynchronized(() async {
      var scaffold = find.byValueKey(AppKeys.homeScaffold);
      await helper.exitIfNotExists(
        scaffold,
        'Scaffold key does not exists in home screen. Or the app is not in home screen.',
      );
      // });
    });

    test('Profile Screen', () async {
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
      await driver.tap(find.pageBack());

      var logoutButton = find.byValueKey(AppKeys.logoutButton);
      await driver.tap(logoutButton);
    });

    test('Login Screen', () async {
      var button = find.byValueKey(AppRoutes.login);
      await helper.exitIfNotExists(
        button,
        'Register button does not exists on home screen.',
      );
      await driver.tap(button);
      var scaffold = find.byValueKey(AppKeys.loginScaffold);
      await helper.exitIfNotExists(
        scaffold,
        'Column key not exists in Login screen.',
      );
      await driver.tap(find.pageBack());
    });

    test('Register Screen', () async {
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
      await driver.tap(find.pageBack());
    });
  });
}

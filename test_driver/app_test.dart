// // Imports the Flutter Driver API.
// import 'package:englishfun_v2/flutter_test/flutter_test.helper.dart';
// import 'package:englishfun_v2/services/keys.dart';
// import 'package:englishfun_v2/services/routes.dart';
// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';

// /* App integration test

//   Goal
//     - to check if the page is properly opened.
//     - to check if the content of the page is properly shown.

//   Tests
//     - page open test & contents test on all pages.
//     - check hearing exercise exists on home screen.
//     - check if there is any chat message on chatting screen.
//     - check if any video exists in the list on hearing screen.
//     - check if there is any photos on phonics screen.
//     - tap on test start on test screen and see if there is any question on test page.
//     - check if the drawer is openable. 

//   TODO
//     - Check for each item on the drawer if they appear.


// */

// void main() {
//   group('Page Checkup: ', () {
//     FlutterDriver driver;
//     TestHelper helper;

//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//       helper = TestHelper(driver);
//     });

//     tearDownAll(() async {
//       if (driver != null) {
//         driver.close();
//       }
//     });

//     test('Home page', () async {
//       await delay(1000);
//       await driver.runUnsynchronized(() async {
//         var column = find.byValueKey(Keys.homeColumn);
//         await helper.exitIfNotExists(column,
//             'Column key not exists in home screen. Or the app is not in home screen.');

//         var hearingCarousel = find.byValueKey(Keys.homeHearingCarousel);
//         await helper.exitIfNotExists(
//             hearingCarousel, 'Hearing exercise not exists in home screen');
//       });
//     });

//     test('Drawer Open/Close', () async {
//       await delay(1000);
//       await driver.runUnsynchronized(() async {

//         /// close
//         var drawerOpenButton = find.byValueKey(Keys.appHeaderDrawerButton);
//         await helper.exitIfNotExists(drawerOpenButton, 'Drawer button not exists');
//         await driver.tap(drawerOpenButton);

//         /// close
//         var drawerCloseButton = find.byValueKey(Keys.appDrawerCloseButton);
//         await helper.exitIfNotExists(drawerCloseButton, 'Drawer close button not exists');
//         await driver.tap(drawerCloseButton);
//       });
//     });

//     test('Start page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.start);
//         await helper.exitIfNotExists(button, 'start button not exists');
//         await driver.tap(button);

//         var column = find.byValueKey(Keys.startPageColumn);
//         await helper.exitIfNotExists(
//             column, 'column key in start page not found.');

//         await driver.tap(find.byValueKey(Keys.appHeaderBackButton));
//       });
//     });

//     test('Word list page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.wordList);
//         await helper.exitIfNotExists(button, 'Words button not exists');
//         await driver.tap(button);

//         var listItems = find.byValueKey(Keys.wordListItems);
//         await helper.exitIfNotExists(
//             listItems, 'list item key in word list page not found.');

//         await driver.tap(find.pageBack());

//       });
//     });

//     /// 테스트 할 때, init() 에서 Markdown 페이지가 멈춰서 안됨
//     test('Grammar page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.grammar);
//         await helper.exitIfNotExists(button, 'Grammar button not exists');
//         await driver.tap(button);

//         var scaffold = find.byValueKey(Keys.grammarScaffold);
//         await helper.exitIfNotExists(
//             scaffold, 'Scaffold key in Grammar page not found.');

//         await driver.tap(find.pageBack());
//       });
//     });

//     test('Expression page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.expression);
//         await helper.exitIfNotExists(button, 'Expression button not exists');
//         await driver.tap(button);

//         var scaffold = find.byValueKey(Keys.expressionScaffold);
//         await helper.exitIfNotExists(
//             scaffold, 'Scaffold key in Expression page not found.');

//         await driver.tap(find.pageBack());
//       });
//     });

//     test('Listening page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.listening);
//         await helper.exitIfNotExists(button, 'Listening button not exists');
//         await driver.tap(button);

//         var column = find.byValueKey(Keys.listeningPageColumn);

//         await helper.exitIfNotExists(
//             column, 'Column key in Listening page not found.');

//         await driver.tap(find.byValueKey(Keys.appHeaderBackButton));
//       });
//     });

//     test('Hearing page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.hearing);
//         await helper.exitIfNotExists(button, 'Hearing button not exists');
//         await driver.tap(button);

//         var content = find.byValueKey(Keys.hearingPageContent);
//         await helper.exitIfNotExists(
//             content, 'Content key in Hearing page not found.');

//         var listItem = find.byValueKey(Keys.hearingListItem);
//         await helper.exitIfNotExists(
//             listItem, 'No hearing video exist in Hearing oage.');

//         await driver.tap(find.pageBack());
//       });
//     });

//     test('Phonics page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.phonics);
//         await helper.exitIfNotExists(button, 'Phonics button not exists');
//         await driver.tap(button);

//         var content = find.byValueKey(Keys.phonicsPageContent);
//         await helper.exitIfNotExists(
//             content, 'Content key in Phonics page not found.');

//         var itemImage = find.byValueKey(Keys.phonicsItemImage);
//         await helper.exitIfNotExists(
//             itemImage, 'phonicsItemImage key in Phonics page not found.');

//         await driver.tap(find.pageBack());
//       });
//     });

//     test('Chat page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.chatting);
//         await helper.exitIfNotExists(button, 'Chat button not exists');
//         await driver.tap(button);

//         var column = find.byValueKey(Keys.chatWidgetColumn);
//         await helper.exitIfNotExists(
//             column, 'Column key in Chat page not found.');

//         var chatMessage = find.byValueKey(Keys.chatMessage1);
//         await helper.exitIfNotExists(
//             chatMessage, 'ChatMessage key in Chat page not found.');

//         await driver.tap(find.pageBack());
//       });
//     });

//     test('Help page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.help);
//         await helper.exitIfNotExists(button, 'Help button not exists');
//         await driver.tap(button);

//         var scaffold = find.byValueKey(Keys.helpScaffold);
//         await helper.exitIfNotExists(
//             scaffold, 'Scaffold key in Chat page not found.');

//         await driver.tap(find.pageBack());
//       });
//     });

//     test('Setting page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.setting);
//         await helper.exitIfNotExists(button, 'Setting button not exists');
//         await driver.tap(button);

//         var content = find.byValueKey(Keys.settingPageContent);
//         await helper.exitIfNotExists(
//             content, 'Content key in Setting page not found.');

//         await driver.tap(find.pageBack());
//       });
//     });

//     test('Test page', () async {
//       await driver.runUnsynchronized(() async {
//         await delay(1000);

//         var button = find.byValueKey(Routes.testStart);
//         await helper.exitIfNotExists(button, 'Test button not exists');
//         await driver.tap(button);

//         var column = find.byValueKey(Keys.testPageColumn);
//         await helper.exitIfNotExists(
//             column, 'Column key in Phonics page not found.');

//         var startButton = find.byValueKey(Keys.testStartButton);
//         await helper.exitIfNotExists(
//             startButton, 'Test Start button not exists');
//         await driver.tap(startButton);

//         var question = find.byValueKey(Keys.testQuestion1);
//         await helper.exitIfNotExists(
//             question, 'testQuestion key in Test page not found.');

//         // await driver.tap(find.byValueKey('backButton'));
//       });
//     });
//   });
// }

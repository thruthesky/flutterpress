import 'package:get/get.dart';

class AppTranslations extends Translations {
  Map<String, Map<String, String>> get keys => {
        'en': {
          'yes': 'Yes',
          'no': 'No',
          'confirm': 'Confirm',
          'cancel': 'Cancel',
        },
        'ko': {
          'yes': '@T Yes',
          'no': '@T No',
          'confirm': '@T Confirm',
          'cancel': '@T Cancel',
        },
      };
}

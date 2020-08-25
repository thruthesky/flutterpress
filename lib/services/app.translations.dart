import 'package:get/get.dart';

class AppTranslations extends Translations {
  Map<String, Map<String, String>> get keys => {
        'en': {
          'home': 'Home',
          'yes': 'Yes',
          'no': 'No',
          'confirm': 'Confirm',
          'cancel': 'Cancel',
          'submit': 'Submit',
          
          'login': 'Login',
          'register': 'Register',
          'profile': 'Profile',
          'update': 'Update',
          'logout': 'Logout',
          'resign': 'Resign',
          'confirmResign': 'Are you sure you want to resign?',

          'email': 'Email',
          'password': 'Password',
          'nickname': 'Nickname',
          'firstname': 'Firstname',
          'lastname': 'Lastname',

          'error': 'Error',

          'user_email_empty': 'Email is empty!',
          'user_pass_empty': 'Password is empty!',
          'nickname_empty': 'Nickname is empty!',
          'wrong_password': 'Invalid login credential',
          'invalid_email_format': 'Invalid Email format.',

        },
        'ko': {
          'home': '@T Home',
          'yes': '@T Yes',
          'no': '@T No',
          'confirm': '@T Confirm',
          'cancel': '@T Cancel',
          'submit': '@T Submit',

          'login': '@T Login',
          'register': '@T Register',
          'profile': '@T Profile',
          'update': '@T Update',
          'logout': '@T Logout',
          'resign': '@T Resign',
          'confirmResign': '@T Are you sure you want to resign?',

          'email': '@T Email',
          'password': '@T Password',
          'nickname': '@T Nickname',
          'firstname': '@T Firstname',
          'lastname': '@T Lastname',

          'error': 'Error',

          'user_email_empty': '@T Email is empty!',
          'user_pass_empty': '@T Password is empty!',
          'nickname_empty': '@T Nickname is empty!',
          'wrong_password': '@T Invalid login credential',
          'invalid_email_format': '@T Invalid Email format.',

        },
      };
}

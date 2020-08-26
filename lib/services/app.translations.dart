import 'package:get/get.dart';

class AppTranslations extends Translations {
  Map<String, Map<String, String>> get keys => {
        'en': {
          'version': 'Version',
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
          'postList': 'Post list',
          'loading': 'Loading posts ..',
          'createPost': 'Create Post',
        },
        'ko': {
          'version': '버전',
          'home': '홈',
          'yes': '예',
          'no': '아니오',
          'confirm': '확인',
          'cancel': '취소',
          'submit': '전송',
          'login': '로그인',
          'register': '회원가입',
          'profile': '회원 정보',
          'update': '업데이트',
          'logout': '로그아웃',
          'resign': '회원 탈퇴',
          'confirmResign': '정말 회원 탈퇴를 하시겠습니까?',
          'email': '이메일',
          'password': '비밀번호',
          'nickname': '닉네임',
          'firstname': '이름',
          'lastname': '성',
          'error': '에러',
          'user_email_empty': '이메일 주소를 입력하세요.',
          'user_pass_empty': '비밀번호를 입력하세요.',
          'nickname_empty': '닉네임을 입력하세요.',
          'wrong_password': '비밀번호가 올바르지 않습니다.',
          'invalid_email_format': '이메일 형식이 올바르지 않습니다.',
          'postList': '@T Post list',
          'loading': '@T Loading posts ..',
          'createPost': '@T Create Post',
        },
      };
}

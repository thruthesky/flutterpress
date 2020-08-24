# flutterpress



## Develoopers Guidelines


### Registeration

```dart
() async {
  try {
      final WordpressController wc = Get.find();
    var re = await wc.register({
      'user_email': 'cherry@test.com',
      'user_pass': 'pw,--3Uuo',
      'nickname': 'ShouldBeDisplayName',
      'anyvalue': 'canBePut'
    });
    print('re: $re');
  } catch (e) {
    print('Got error:');
    print(e);
  }
}();
```

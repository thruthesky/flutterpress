# flutterpress

## Develoopers Guidelines

### Reqeusts

* When there is protocal error(Not server error or internal script error) from Backend, it throws an error.

```dart
() async {
  try {
    /// Request without route. Resulting an exception.
    await wc.getHttp({});
  } catch (e) {
    /// Got exception.
    print('Caught error:');
    print(e);
  }
}();
```

### Registeration

* Example 1

```dart
() async {
    try {
    await wc.register(
        {'user_email': 'email2@gmail.com', 'user_pass': 'qso8,df'});
    } catch (e) {
    print('Caught error: $e');
    }
}();
```

* Example 2

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

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

### Test

* How to do the integration test.
  * Run the app in debug mode with `App Instrument` launch option.
    * And wait for the app download resources, video, audios, photos. ( It will take some minutes but it's only one time process. No need to wait on second run.)
  * `Reset test` on English test screen.
  * Run `export VM_SERVICE_URL="http://127.0.0.1:8181/"; dart test_driver/app_test.dart` to test. You can run this after updating the source code.


## Social login

* For Firebase, we use 'sonub' project.
* For Facebook, we use 'sonub' project
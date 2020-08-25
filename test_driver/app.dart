import 'package:flutter_driver/driver_extension.dart';
import 'package:flutterpress/globals.dart';
import 'package:flutterpress/main.dart' as app;
import 'package:flutterpress/globals.dart' as globals;

void main() {
  globals.isTestActive = true;
  enableFlutterDriverExtension();
  app.main();
}

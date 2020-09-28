
import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:get/get.dart';

class MineMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: context.height * .3,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(md),
              child: Text('Choose Action'),
            ),
            FlatButton(
              child: Text('update'.tr),
              onPressed: () {
                Get.back(result: 'update');
              },
            ),
            FlatButton(
              child: Text('delete'.tr),
              onPressed: () {
                Get.back(result: 'delete');
              },
            ),
            FlatButton(
              child: Text('close'.tr),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}

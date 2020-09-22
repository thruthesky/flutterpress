import 'package:flutter/material.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:get/get.dart';

class AppSimpleDialog extends StatelessWidget {

  final String title;
    final Widget content;
    final String textConfirm;
    final String textCancel;
    final Function onConfirm;
    final Function onCancel;

  AppSimpleDialog({ 
    this.title,
    this.content,
    this.textCancel,
    this.textConfirm,
    this.onCancel,
    this.onConfirm,
   });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title), SizedBox(height: 10), content],
        ),
        children: [
          Divider(),
          Row(
            children: [
              FlatButton(
                key: ValueKey(Keys.dialogConfirmButton),
                onPressed: onConfirm != null
                    ? () {
                        Get.back();
                        onConfirm();
                      }
                    : null,
                child: Text(textConfirm ?? 'yes'.tr),
              ),
              Spacer(),
              FlatButton(
                key: ValueKey(Keys.dialogCancelButton),
                onPressed: () {
                  Get.back();
                  if (onCancel != null) onCancel();
                },
                child: Text('cancel'.tr),
              ),
            ],
          )
        ],
      );
  }
}
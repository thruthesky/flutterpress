import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

enum MineOption { update, delete, cancel }

typedef MineSelection(MineOption option);

class MineButton extends StatelessWidget {
  final MineSelection onSelect;

  MineButton({this.onSelect});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.ellipsisV),
      iconSize: md,
      onPressed: () async {
        var res = await Get.bottomSheet(
          MineMenu(),
          backgroundColor: Colors.white,
        );
        onSelect(res);
      },
    );
  }
}

class MineMenu extends StatelessWidget {
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
                Get.back(result: MineOption.update);
              },
            ),
            FlatButton(
              child: Text('delete'.tr),
              onPressed: () {
                Get.back(result: MineOption.delete);
              },
            ),
            FlatButton(
              child: Text('close'.tr),
              onPressed: () {
                Get.back(result: MineOption.cancel);
              },
            )
          ],
        ),
      ),
    );
  }
}

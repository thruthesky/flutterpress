import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

enum MineOption { update, delete, cancel }

typedef MineSelection(MineOption option);

class MineButton extends StatelessWidget {
  final MineSelection onSelect;
  final double iconSize;

  MineButton({this.onSelect, this.iconSize = md});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: BoxConstraints(maxHeight: iconSize * 2),
      icon: Icon(FontAwesomeIcons.ellipsisV),
      iconSize: iconSize,
      onPressed: () async {
        var res = await Get.bottomSheet(
          MineMenu(),
          backgroundColor: Colors.white,
        );
        onSelect(res ?? MineOption.cancel);
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

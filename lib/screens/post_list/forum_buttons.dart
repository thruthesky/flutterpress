import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForumButtons extends StatelessWidget {
  final bool showReplyButton;

  final bool inEdit;
  final bool mine;

  final int likeCount;
  final int dislikeCount;

  final Function onReplyTap;
  final Function onUpdateTap;
  final Function onDeleteTap;
  final Function onVoteTap;

  ForumButtons({
    this.showReplyButton = false,
    this.inEdit = false,
    this.mine,
    this.likeCount = 0,
    this.dislikeCount = 0,
    this.onReplyTap,
    @required this.onUpdateTap,
    @required this.onDeleteTap,
    @required this.onVoteTap(String choice),
  });

  onVoteButtonTapped(String choice) {
    if (!AppService.wc.isUserLoggedIn) {
      AppService.confirmDialog(
        'loginFirst'.tr,
        Text('Login first to vote'),
        textConfirm: 'login'.tr,
        onConfirm: () => Get.toNamed(Routes.login),
        onCancel: () {
          return;
        },
      );
    } else {
      onVoteTap(choice);
    }
  }

  Widget buildButton({String label, Function onTap}) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(right: sm),
        child: Text(
          label,
          style: TextStyle(
            fontSize: md,
            color: onTap != null ? Colors.blue[500] : Colors.grey,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    var likeText = likeCount > 0 ? 'like'.tr + '($likeCount)' : 'like'.tr;
    var dislikeText =
        dislikeCount > 0 ? 'dislike'.tr + '($dislikeCount)' : 'dislike'.tr;

    var buttons = [
      if (showReplyButton) {'label': 'reply'.tr, 'onTap': onReplyTap},
      {
        'label': likeText,
        'onTap': mine ? null : () => onVoteButtonTapped('like')
      },
      {
        'label': dislikeText,
        'onTap': mine ? null : () => onVoteButtonTapped('dislike')
      },
    ];

    // if (mine) {
    //   buttons.addAll([
    //     {'label': 'update'.tr, 'onTap': onUpdateTap},
    //     {'label': 'delete'.tr, 'onTap': onDeleteTap}
    //   ]);
    // }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        for (Map<String, dynamic> button in buttons)
          buildButton(label: button['label'], onTap: button['onTap']),
        if (mine)
          GestureDetector(
            child: Icon(FontAwesomeIcons.cog, size: md, color: Colors.black54),
            onTap: () async {
              var res = await Get.bottomSheet(
                MineMenu(),
                backgroundColor: Colors.white,
              );
              if (res == 'update') onUpdateTap();
              if (res == 'delete') onDeleteTap();
            },
          )
      ]),
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

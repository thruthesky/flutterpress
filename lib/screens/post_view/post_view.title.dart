import 'package:flutter/material.dart';
import 'package:flutterpress/screens/post_view/forum_buttons.dart';
import 'package:get/get.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostViewHeader extends StatelessWidget {
  PostViewHeader(
    this.post, {
    this.titleSize = 20,
    this.onUpdateButtonTap,
    this.onDeleteButtonTap,
  });

  final PostModel post;
  final double titleSize;
  final Function onUpdateButtonTap;
  final Function onDeleteButtonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(sm),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: (titleSize * 3) + sm,
                maxWidth: double.infinity,
              ),
              child: Text(
                post.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: md, left: md, right: md, top: sm),
          child: Row(
            children: [
              CircularAvatar(
                photoURL: post.authorPhotoUrl,
                height: 40,
                width: 40,
              ),
              SizedBox(width: xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${post.authorName} - No. ${post.id} - Date: ${post.date}',
                      style: TextStyle(fontSize: sm),
                    ),
                    Text(post.slug + ' - Views 201',
                        style: TextStyle(fontSize: md))
                  ],
                ),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.ellipsisV),
                iconSize: 16,
                onPressed: () async {
                  var res = await Get.bottomSheet(
                    MineMenu(),
                    backgroundColor: Colors.white,
                  );
                  if (res == 'update' && onUpdateButtonTap != null) onUpdateButtonTap();
                  if (res == 'delete' && onDeleteButtonTap != null) onDeleteButtonTap();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

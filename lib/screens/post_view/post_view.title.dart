import 'package:flutter/material.dart';
import 'package:flutterpress/screens/post_view/mine_menu_button.dart';
import 'package:flutterpress/services/app.service.dart';
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
          margin: EdgeInsets.only(bottom: xs, left: md, right: md, top: xs),
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
                      '${AppService.authorName(post.authorName)} - No. ${post.id} - Date: ${post.date}',
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
                    MineMenuButton(),
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

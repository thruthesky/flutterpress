import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutterpress/screens/post_list/mine_button.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';

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
        if (!post.deleted)
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
              if (!post.deleted) ...[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppService.authorName(post.authorName)} - No. ${post.id} - Date: ${post.date}',
                        style: TextStyle(fontSize: sm),
                      ),

                      /// TODO: view count
                      Text(
                        post.slug + ' - 201 views',
                        style: TextStyle(fontSize: md),
                      )
                    ],
                  ),
                ),
                if (AppService.isMine(post))
                  MineButton(
                    onSelect: (option) {
                      if (option == MineOption.update &&
                          onUpdateButtonTap != null) {
                        onUpdateButtonTap();
                      }
                      if (option == MineOption.delete &&
                          onDeleteButtonTap != null) {
                        onDeleteButtonTap();
                      }
                    },
                  ),
              ],
              if (post.deleted)
                Text(
                  'deleted'.tr,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0x99000000),
                    fontWeight: FontWeight.w500,
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}

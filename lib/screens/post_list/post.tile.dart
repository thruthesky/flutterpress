import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
import 'package:flutterpress/widgets/commons/common.image.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    final withUserPhoto = !isEmpty(post.authorPhotoUrl);
    final withFiles = !isEmpty(post.files);

    String firstline = post.date;
    if (post.like > 0) firstline += ' - ${post.like} Liked';
    if (post.dislike > 0) firstline += ' - ${post.dislike} Disliked';

    String lastLine = 'No comments.';
    if (post.comments.length > 0) {
      lastLine = '(${post.comments.length}) comments.';
      lastLine +=
          ' ${post.comments[post.comments.length - 1].content.replaceAll('\n', ' ')}';
    }

    Widget userAvatar;
    double avatarSize = 45;
    double firstLineAlignment = 0;

    if ((!withUserPhoto && !withFiles) || (withUserPhoto && withFiles)) {
      firstline = post.authorName + ' - $firstline';
    }
    if (withUserPhoto && withFiles) {
      avatarSize = 35;
      firstLineAlignment = 52;
    }
    if (withFiles && !withUserPhoto) firstLineAlignment = 102;
    if (withUserPhoto && !withFiles) firstLineAlignment = 82;
    if (withUserPhoto) {
      userAvatar = CircularAvatar(
        photoURL: post.authorPhotoUrl,
        width: avatarSize,
        height: avatarSize,
        withShadow: true,
        shadowColor: Color(0x66000000),
      );
    }

    return Container(
      height: 78,
      margin: EdgeInsets.all(md),
      child: Stack(
        children: [
          Positioned(
            left: firstLineAlignment,
            child: Text(
              firstline,
              style: TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (withUserPhoto && !withFiles) ...[
                Container(
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      userAvatar,
                      SizedBox(height: xs),
                      Text(
                        post.authorName,
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
              if (withFiles)
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CommonImage(
                    post.files[0].thumbnailUrl,
                    height: 60,
                    width: 90,
                  ),
                ),
              if (withUserPhoto || withFiles) SizedBox(width: sm),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      post.content.replaceAll('\n', ' '),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0x99000000),
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      lastLine,
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          if (withFiles && withUserPhoto)
            Positioned(
              child: userAvatar,
              left: sm,
            ),
        ],
      ),
    );
  }
}

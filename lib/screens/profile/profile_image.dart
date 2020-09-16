import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
import 'package:get/state_manager.dart';

class ProfileImage extends StatelessWidget {
  final double height;
  final double width;

  ProfileImage({
    this.height = 150.0,
    this.width = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      builder: (wc) {
        return CircularAvatar(
          photoURL: wc.user.photoURL,
          height: height,
          width: width,
        );
      },
    );
  }
}

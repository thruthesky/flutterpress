import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
import 'package:get/state_manager.dart';

class ProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final bool withShadow;
  final bool hiddenWhenLoggedOut;

  ProfileImage({
    this.height = 150.0,
    this.width = 150.0,
    this.withShadow = true,
    this.hiddenWhenLoggedOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      builder: (wc) {
        if (!wc.isUserLoggedIn && hiddenWhenLoggedOut) {
          return SizedBox.shrink();
        }
        return CircularAvatar(
          photoURL: wc.user.photoURL,
          height: height,
          width: width,
          withShadow: withShadow,
        );
      },
    );
  }
}

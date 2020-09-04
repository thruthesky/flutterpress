import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:get/get.dart';

class ProfileImage extends StatefulWidget {
  final double size;

  ProfileImage({this.size = 150.0});

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      builder: (wc) {
        var image = wc.isUserLoggedIn && !isEmpty(wc.user.photoURL)
            ? NetworkImage(wc.user.photoURL)
            : AssetImage('assets/images/anonymous.jpg');

        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: image,
            ),
          ),
        );
      },
    );
  }
}

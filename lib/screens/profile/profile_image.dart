import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  final double size;

  ProfileImage({this.size = 150.0});

  Widget buildRoundImage(ImageProvider provider) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: provider,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      builder: (wc) {
        return wc.isUserLoggedIn && !isEmpty(wc.user.photoURL)
            ? CachedNetworkImage(
                width: size,
                height: size,
                imageUrl: wc.user.photoURL,
                imageBuilder: (context, provider) {
                  return buildRoundImage(provider);
                },
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : buildRoundImage(AssetImage('assets/images/anonymous.jpg'));
      },
    );
  }
}

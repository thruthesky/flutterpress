import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final String photoURL;
  final double height;
  final double width;

  CircularAvatar({
    this.photoURL = '',
    this.height = 150.0,
    this.width = 150.0,
  });

  Widget buildRoundImage(ImageProvider provider) {
    return Container(
      width: width,
      height: height,
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
    return !isEmpty(photoURL)
        ? CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: photoURL,
            imageBuilder: (context, provider) {
              return buildRoundImage(provider);
            },
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : buildRoundImage(AssetImage('assets/images/anonymous.jpg'));
  }
}

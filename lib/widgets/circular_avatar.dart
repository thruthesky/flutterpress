import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/widgets/commons/common.circle_image.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';

class CircularAvatar extends StatelessWidget {
  final String photoURL;
  final double height;
  final double width;

  CircularAvatar({
    this.photoURL = '',
    this.height = 150.0,
    this.width = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return !isEmpty(photoURL)
        ? CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: photoURL,
            placeholder: (context, url) => CommonSpinner(),
            imageBuilder: (context, provider) {
              return CircleImageContainer(
                imageProvider: provider,
                width: width,
                height: height,
              );
            },
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : CircleImageContainer(
            imageProvider: AssetImage('assets/images/anonymous.jpg'),
            width: width,
            height: height,
          );
  }
}

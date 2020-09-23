import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/widgets/commons/common.circle_image.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';

class CircularAvatar extends StatelessWidget {
  final String photoURL;
  final double height;
  final double width;

  final bool withShadow;
  final double shadowSpread;
  final double shadowBlur;
  final Offset shadowPosition;
  final Color shadowColor;

  CircularAvatar({
    this.photoURL = '',
    this.height = 150.0,
    this.width = 150.0,
    this.withShadow = false,
    this.shadowSpread = 2,
    this.shadowBlur = 3,
    this.shadowPosition = const Offset(0, 2),
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    BoxShadow shadow;
    if (withShadow) {
      shadow = BoxShadow(
        spreadRadius: shadowSpread,
        blurRadius: shadowBlur,
        offset: shadowPosition,
        color: shadowColor ?? Colors.grey.withOpacity(0.7),
      );
    }

    return !isEmpty(photoURL)
        ? CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: photoURL,
            placeholder: (context, url) => CommonSpinner(),
            imageBuilder: (context, provider) {
              return CommonCircleImage(
                imageProvider: provider,
                width: width,
                height: height,
                shadows: withShadow ? [shadow] : null,
              );
            },
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : CommonCircleImage(
            imageProvider: AssetImage('assets/images/anonymous.jpg'),
            width: width,
            height: height,
            shadows: withShadow ? [shadow] : null,
          );
  }
}

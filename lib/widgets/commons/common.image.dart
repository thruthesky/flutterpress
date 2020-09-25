import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import './common.spinner.dart';

typedef Widget WidgetBuilder(
  BuildContext context,
  ImageProvider imageProvider,
);

class CommonImage extends StatelessWidget {
  CommonImage(
    this.url, {
    this.fit = BoxFit.cover,
    this.fadeInOut = true,
    this.width,
    this.height,
    this.defaultChild,
    this.builder,
  });
  final String url;
  final BoxFit fit;

  final double width;
  final double height;

  /// [fadeInOut] 이 값이 참이면, 서서히 이미지가 사라지고, 서서히 나타난다. 기본 값: true, 만약, 이 값이 false 이면, 이미지가 깜빡이며 나타날 수 있다.
  final bool fadeInOut;

  /// [defaultChild] 만약, 이미지가 null 인 경우, 대신 표시 할 이미지를 지정 할 수 있다.
  final Widget defaultChild;

  final WidgetBuilder builder;
  @override
  Widget build(BuildContext context) {
    if (url == null) {
      if (defaultChild != null)
        return defaultChild;
      else
        return Center(child: Icon(Icons.picture_in_picture_alt));
    }
    if (url.indexOf('http') != 0) return Icon(Icons.error);

    // print('egine image url: $url');

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => CommonSpinner(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageBuilder: builder,
      fadeInDuration: fadeInOut
          ? const Duration(milliseconds: 500)
          : const Duration(milliseconds: 0),
      fadeOutDuration: fadeInOut
          ? const Duration(milliseconds: 500)
          : const Duration(milliseconds: 0),
    );
  }
}

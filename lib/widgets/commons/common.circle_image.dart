import 'package:flutter/material.dart';

class CommonCircleImage extends StatelessWidget {
  final ImageProvider imageProvider;
  final double height, width;
  final List<BoxShadow> shadows;

  CommonCircleImage({
    this.imageProvider,
    @required this.height,
    @required this.width,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: imageProvider,
        ),
        boxShadow: shadows,
      ),
    );
  }
}

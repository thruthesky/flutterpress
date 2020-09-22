import 'package:flutter/material.dart';

class CircleImageContainer extends StatelessWidget {
  final ImageProvider imageProvider;
  final double height, width;

  CircleImageContainer({
    this.imageProvider,
    @required this.height,
    @required this.width,
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
      ),
    );
  }
}

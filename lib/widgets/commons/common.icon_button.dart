import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final EdgeInsets padding;
  final Function onTap;

  CommonIconButton({
    @required this.icon,
    @required this.onTap,
    this.padding = const EdgeInsets.all(md),
    this.iconSize = md,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding,
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? Color(0xff676767),
        ),
      ),
      onTap: onTap,
    );
  }
}

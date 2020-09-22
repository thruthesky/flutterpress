import 'package:flutter/material.dart';

class LoginSocialIcon extends StatelessWidget {
  LoginSocialIcon({
    @required this.child,
    @required this.text,
    @required this.onTap,
    this.padding = 8.0,
    this.itemSpace = 8.0,
  });
  final Widget child;
  final String text;
  final Function onTap;
  final double padding;
  final double itemSpace;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            child,
            SizedBox(height: itemSpace),
            Text(text),
          ],
        ),
      ),
    );
  }
}

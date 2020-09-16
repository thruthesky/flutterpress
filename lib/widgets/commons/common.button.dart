import 'package:flutter/material.dart';
import 'common.spinner.dart';

/// FutterButton 과 비슷한데, 그냥 텍스트로 클릭이 되는 것이다.
class CommonButton extends StatelessWidget {
  CommonButton({
    this.showSpinner = false,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.onTap,
  });
  final bool showSpinner;
  final Widget child;
  final Function onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            if (showSpinner) ...[
              CommonSpinner(size: 18),
              SizedBox(width: 8.0),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommonAppBar({
    Key key,
    this.title,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 0,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final Widget title;
  final bool centerTitle;
  final Color backgroundColor;
  final double elevation;

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      centerTitle: widget.centerTitle,
      backgroundColor: widget.backgroundColor ?? Color(0xff0283d0),
      elevation: widget.elevation,
    );
  }
}

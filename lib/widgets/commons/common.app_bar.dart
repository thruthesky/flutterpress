import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/profile_image.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommonAppBar({
    Key key,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.showBackButton = true,
    this.backgroundColor,
    this.elevation = 0,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final Widget title;
  final bool centerTitle;
  final bool showBackButton;
  final Color backgroundColor;
  final double elevation;
  final List<Widget> actions;

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      centerTitle: widget.centerTitle,
      automaticallyImplyLeading: widget.showBackButton,
      backgroundColor: widget.backgroundColor ?? Color(0xff0283d0),
      elevation: widget.elevation,
      actions: [
        if (!isEmpty(widget.actions)) ...widget.actions,
        GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: (widget.preferredSize.height - 40) / 2,
              horizontal: 0,
            ),
            child: ProfileImage(
              height: 40,
              width: 40,
              withShadow: false,
              hiddenWhenLoggedOut: true,
            ),
          ),
          onTap: () {
            Get.toNamed(Routes.profile);
          },
        ),
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }
}

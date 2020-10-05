import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/services/app.globals.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
import 'package:flutterpress/widgets/commons/common.icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommonAppDrawer extends StatefulWidget {
  @override
  _CommonAppDrawerState createState() => _CommonAppDrawerState();
}

class _CommonAppDrawerState extends State<CommonAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<WordpressController>(
        builder: (_) {
          return SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                  children: [
                    Spacer(),
                    CommonIconButton(
                      icon: FontAwesomeIcons.home,
                      iconSize: 26,
                      onTap: () {
                        Get.toNamed(Routes.home);
                      },
                    ),
                    CommonIconButton(
                      icon: FontAwesomeIcons.solidTimesCircle,
                      iconSize: 26,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                if (_.isUserLoggedIn)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircularAvatar(
                          photoURL: _.user.photoURL,
                          height: 40,
                          width: 40,
                          withShadow: true,
                        ),
                        SizedBox(height: lg),
                        Text(
                          _.user.nickName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: xs),
                        Text(
                          'Logged in with ${_.user.socialLogin}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0x99000000),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                Divider(
                  color: Color(0x1F000000),
                ),
                if (!_.isUserLoggedIn) ...[
                  DrawerButton(
                    key: ValueKey(Routes.login),
                    icon: FontAwesomeIcons.signInAlt,
                    text: 'Sign-in',
                    spacing: 35,
                    iconSize: 18,
                    onPressed: () => Get.toNamed(Routes.login),
                  ),
                  DrawerButton(
                    key: ValueKey(Routes.register),
                    icon: FontAwesomeIcons.userPlus,
                    text: 'register'.tr,
                    iconSize: 18,
                    spacing: 30,
                    onPressed: () => Get.toNamed(Routes.register),
                  ),
                ],

                /// travel information
                ///
                /// TODO: add travel info forums
                SegmentTitle(text: 'Travel Information'),
                Divider(color: Color(0xD3D3D3D0)),
                DrawerButton(
                  icon: FontAwesomeIcons.checkSquare,
                  iconSize: 24,
                  text: 'Preparation for Travel',
                  onPressed: () {},
                ),
                DrawerButton(
                  icon: FontAwesomeIcons.planeDeparture,
                  text: 'Travel by Yourself',
                  iconSize: 16,
                  onPressed: () {},
                ),
                DrawerButton(
                  icon: FontAwesomeIcons.mapMarked,
                  text: 'Best Travel Spots',
                  iconSize: 18,
                  onPressed: () {},
                ),
                DrawerButton(
                  icon: FontAwesomeIcons.taxi,
                  text: 'Day Trips from Manila',
                  spacing: 33,
                  onPressed: () {},
                ),

                /// forums
                SegmentTitle(text: 'Forums'),
                Divider(color: Color(0xD3D3D3D0)),
                DrawerButton(
                  icon: FontAwesomeIcons.solidQuestionCircle,
                  text: 'Questions and Answers',
                  spacing: 33,
                  onPressed: () => openForum('qna'),
                ),
                DrawerButton(
                  icon: FontAwesomeIcons.solidComments,
                  text: 'Discussions',
                  iconSize: 18,
                  onPressed: () => openForum('discuss'),
                ),
                DrawerButton(
                  icon: FontAwesomeIcons.infoCircle,
                  text: 'Know-Hows',
                  spacing: 33,
                  onPressed: () {
                    /// TODO: add know hows forum
                  },
                ),

                if (kDebugMode) // only in debug mode
                  DrawerButton(
                    icon: FontAwesomeIcons.cogs,
                    text: 'Uncategorized',
                    iconSize: 16,
                    spacing: 33,
                    onPressed: () => openForum('uncategorized'),
                  ),

                if (_.isUserLoggedIn) ...[
                  SizedBox(height: xl),
                  DrawerButton(
                    icon: FontAwesomeIcons.signOutAlt,
                    text: 'logout'.tr,
                    spacing: 33,
                    onPressed: () => _.logout(),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final Key key;
  final IconData icon;
  final String text;
  final double iconSize;
  final Function onPressed;
  final double spacing;

  DrawerButton({
    this.key,
    @required this.icon,
    this.iconSize = 20,
    @required this.text,
    @required this.onPressed,
    this.spacing = xl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        key: key,
        child: Row(
          children: [
            FaIcon(
              icon,
              color: Color(0xFF5F5F5F),
              size: iconSize,
            ),
            SizedBox(width: spacing),
            Text(
              text,
              style: TextStyle(
                color: Color(0x99000000),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class SegmentTitle extends StatelessWidget {
  final String text;

  SegmentTitle({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: md, top: lg),
      child: Text(text, style: TextStyle(color: Color(0x99000000))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:get/state_manager.dart';

class ProfileForumInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      builder: (wc) {
        /// Forum informations
        /// TODO: refactor with real data
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    '10',
                    style: TextStyle(fontSize: 33, color: Color(0xff707070)),
                  ),
                  Divider(thickness: 1, color: Color(0xffe3e3e3)),
                  Text(
                    'Posts',
                    style: TextStyle(fontSize: 12, color: Color(0xff707070)),
                  )
                ],
              ),
            ),
            SizedBox(width: md),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '239',
                    style: TextStyle(fontSize: 33, color: Color(0xff707070)),
                  ),
                  Divider(thickness: 1, color: Color(0xffe3e3e3)),
                  Text(
                    'Comments',
                    style: TextStyle(fontSize: 12, color: Color(0xff707070)),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

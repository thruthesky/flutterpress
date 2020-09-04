import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/screens/profile/profile.update_form.dart';
import 'package:flutterpress/screens/profile/profile_image.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
// import 'package:flutterpress/widgets/file_upload_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.profileScaffold),
      appBar: AppBar(title: Text('profile'.tr)),
      endDrawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ProfileImage(),
                Positioned(
                  bottom: 1,
                  // child: FileUploadButton(),
                  child: Icon(FontAwesomeIcons.camera),
                )
              ],
            ),
            Text('ID: ${wc.user.id}'),
            Text('Email: ${wc.user.userEmail}'),
            Divider(),
            ProfileUpdateForm(),
          ],
        ),
      ),
    );
  }
}

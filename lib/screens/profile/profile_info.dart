import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/screens/profile/profile_image.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/file_upload_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  double uploadProgress = 0;

  updateUserProfile(String url) async {
    try {
      await AppService.wc.profileUpdate({
        'photo_url': url,
      });
      uploadProgress = 0;
      setState(() {});
    } catch (e) {
      AppService.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ProfileImage(),
            Positioned(
              bottom: 1,
              child: FileUploadButton(
                iconColor: Colors.blue[500],
                onProgress: (p) {
                  uploadProgress = p;
                  setState(() {});
                },
                onUploaded: (file) {
                  updateUserProfile(file.thumbnailUrl);
                  uploadProgress = 0;
                  setState(() {});
                },
              ),
            ),
            if (!isEmpty(AppService.wc.user.photoURL))
              Positioned(
                bottom: 1,
                right: 1,
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.trash, color: Colors.red[500]),
                  onPressed: () {
                    AppService.confirmDialog(
                      'deleteProfileImage',
                      Text('confirmDelete'.tr),
                      onConfirm: () {
                        updateUserProfile('');
                      },
                    );
                  },
                ),
              ),
          ],
        ),
        if (uploadProgress != 0)
          Container(
            padding: EdgeInsets.only(top: sm, right: lg, left: lg),
            child: LinearProgressIndicator(
              value: uploadProgress,
            ),
          ),
        SizedBox(height: sm),
        Text('Email: ${AppService.wc.user.userEmail}'),
        Text('Number: ${AppService.wc.user.mobile}'),
      ],
    );
  }
}

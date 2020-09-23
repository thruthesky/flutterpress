import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/screens/profile/info_text.dart';
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
  final WordpressController wc = Get.find();

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
    return Container(
      padding: EdgeInsets.all(md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Touch and update your information',
            style: TextStyle(
              fontSize: sm,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: lg),

          /// profile image & email
          Center(
            child: Stack(
              children: [
                ProfileImage(
                  width: 160,
                  height: 160,
                  
                ),
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
                      icon:
                          Icon(FontAwesomeIcons.trash, color: Colors.red[500]),
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
          ),
          if (uploadProgress != 0)
            Container(
              padding: EdgeInsets.only(top: sm, right: lg, left: lg),
              child: LinearProgressIndicator(
                value: uploadProgress,
              ),
            ),
          Container(
            padding: EdgeInsets.all(sm),
            width: double.infinity,
            child:
                InfoText(wc.user.email, centered: true, iconRightSpacing: sm),
          ),

          SizedBox(height: md),

          /// other info box
          Container(
            padding: EdgeInsets.all(sm),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: InfoText(
                    wc.user.nickName,
                    iconRightSpacing: sm,
                    fontSize: 20,
                    label: 'nickname'.tr,
                  ),
                ),
                SizedBox(height: lg),
                SizedBox(
                  width: double.infinity,
                  child: InfoText(
                    wc.user.mobile,
                    label: 'mobileNo'.tr,
                    fontSize: 20,
                    iconRightSpacing: sm,
                  ),
                ),
                SizedBox(height: lg),
                SizedBox(
                  width: double.infinity,
                  child: InfoText(
                    wc.user.birthday,
                    label: 'birthday'.tr,
                    fontSize: 20,
                    iconRightSpacing: sm,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[200],
            ),
          ),

          SizedBox(height: xl),

          /// Forum informations
          /// TODO: refactor with real data
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('10', style: TextStyle(fontSize: lg)),
                    Divider(),
                    Text('Posts')
                  ],
                ),
              ),
              SizedBox(width: md),
              Expanded(
                child: Column(
                  children: [
                    Text('239', style: TextStyle(fontSize: lg)),
                    Divider(),
                    Text('Comments')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

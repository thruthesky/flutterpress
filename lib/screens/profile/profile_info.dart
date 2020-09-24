import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/screens/profile/info.update_form.dart';
import 'package:flutterpress/screens/profile/info_text.dart';
import 'package:flutterpress/screens/profile/profile.forum_info.dart';
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

  onInfoTapped(Widget dialog) {
    Get.dialog(dialog, barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      builder: (wc) {
        return Container(
          padding: EdgeInsets.all(md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Touch and update your information',
                style: TextStyle(
                  fontSize: sm,
                  color: Color(0xff707070),
                ),
              ),
              SizedBox(height: lg),

              /// profile image & email
              Center(
                child: Stack(
                  children: [
                    ProfileImage(
                      width: 145,
                      height: 145,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: FileUploadButton(
                        iconColor: Color(0xFF4e4e4e),
                        iconSize: 30,
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
                    if (!isEmpty(wc.user.photoURL))
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.trash,
                            color: Colors.red[500],
                            size: 30,
                          ),
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
                  child: LinearProgressIndicator(value: uploadProgress),
                ),

              /// Full name
              /// TODO: show user's fullname instead of email
              Container(
                padding: EdgeInsets.all(sm),
                width: double.infinity,
                child: InfoText(
                  wc.user.name,
                  fontSize: 20,
                  centered: true,
                  iconRightSpacing: sm,
                  isRequired: true,
                  requiredError: 'err_update_name'.tr,
                  onTapped: () {
                    onInfoTapped(InfoUpdateForm(
                      title: 'Input your name',
                      value: wc.user.name,
                      paramName: 'name',
                      errorMessage: 'name_empty'.tr,
                    ));
                  },
                ),
              ),

              SizedBox(height: md),

              /// other info box
              Container(
                padding: EdgeInsets.all(sm),
                child: Column(
                  children: [
                    if (wc.user.isRegisteredWithWordpress) ...[
                      SizedBox(
                        width: double.infinity,
                        child: InfoText(
                          wc.user.email,
                          iconRightSpacing: sm,
                          fontSize: 16,
                          label: 'email'.tr,
                        ),
                      ),
                      SizedBox(height: lg),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: InfoText(
                        wc.user.nickName,
                        fontSize: 22,
                        iconRightSpacing: sm,
                        label: 'nickname'.tr,
                        isRequired: true,
                        requiredError: 'err_update_nickname'.tr,
                        onTapped: () {
                          onInfoTapped(InfoUpdateForm(
                            title: 'Input your nickname',
                            value: wc.user.nickName,
                            paramName: 'nickname',
                            errorMessage: 'nickname_empty'.tr,
                          ));
                        },
                      ),
                    ),
                    SizedBox(height: lg),
                    SizedBox(
                      width: double.infinity,
                      child: InfoText(
                        wc.user.mobile,
                        fontSize: 22,
                        label: 'mobileNo'.tr,
                        iconRightSpacing: sm,
                        isRequired: true,
                        requiredError: 'err_update_mobile'.tr,
                        onTapped: () {
                          /// TODO: update function.
                          print('TODO: mobile update');
                        },
                      ),
                    ),
                    SizedBox(height: lg),
                    SizedBox(
                      width: double.infinity,
                      child: InfoText(
                        wc.user.birthday,
                        fontSize: 22,
                        label: 'birthday'.tr,
                        iconRightSpacing: sm,
                        isRequired: true,
                        requiredError: 'err_update_birthday'.tr,
                        onTapped: () {
                          /// TODO: update function.
                          print('TODO: birthday update');
                        },
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
              ProfileForumInfo(),
            ],
          ),
        );
      },
    );
  }
}

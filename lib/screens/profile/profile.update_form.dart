import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:get/get.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';

class ProfileUpdateForm extends StatefulWidget {
  @override
  ProfileUpdateFormState createState() {
    return ProfileUpdateFormState();
  }
}

/// TODO
///   - Add validation
///   - Update UI
class ProfileUpdateFormState extends State<ProfileUpdateForm> {
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  TextEditingController nickname;
  TextEditingController firstname;
  TextEditingController lastname;

  @override
  void initState() {
    nickname = TextEditingController(text: wc.user.nickName);
    firstname = TextEditingController(text: wc.user.firstName);
    lastname = TextEditingController(text: wc.user.lastName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppTextInputField(
            key: ValueKey(AppKeys.nicknameInput),
            hintText: 'nickname'.tr,
            controller: nickname,
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
          ),
          AppTextInputField(
            hintText: 'firstname'.tr,
            controller: firstname,
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
          ),
          AppTextInputField(
            hintText: 'lastname'.tr,
            controller: lastname,
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
          ),
          Divider(),
          Row(
            children: [
              RaisedButton(
                key: ValueKey(AppKeys.formSubmitButton),
                onPressed: () async {
                  try {
                    await wc.profileUpdate({
                      'nickname': nickname.text,
                      'first_name': firstname.text,
                      'last_name': lastname.text,
                    });
                  } catch (e) {
                    AppService.error('$e'.tr);
                  }
                },
                child: Text('update'.tr),
              ),
              Spacer(),
              RaisedButton(
                key: ValueKey(AppKeys.resignButton),
                color: Colors.red[300],
                textColor: Colors.white,
                child: Text('resign'.tr),
                onPressed: () {
                  AppService.confirmDialog(
                    'resign'.tr,
                    Text('confirmResign'.tr),
                    onConfirm: () async {
                      Get.back();
                      try {
                        await wc.resign();
                        Get.back();
                      } catch (e) {
                        AppService.error('$e'.tr);
                      }
                    },
                    onCancel: () => Get.back,
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

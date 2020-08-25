import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.service.dart';
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
    firstname = TextEditingController(text: wc.user.firstName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'nickname'.tr),
            controller: nickname,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'firstname'.tr),
            controller: firstname,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'lastname'.tr),
            controller: lastname,
          ),
          Divider(),
          Row(
            children: [
              RaisedButton(
                onPressed: () async {
                  try {
                    await wc.profileUpdate({
                      'nickname': nickname,
                      'first_name': firstname,
                      'last_name': lastname,
                    });
                  } catch (e) {
                    AppService.error('error'.tr, e);
                  }
                },
                child: Text('update'.tr),
              ),
              Spacer(),
              RaisedButton(
                color: Colors.red[300],
                textColor: Colors.white,
                child: Text('resign'.tr),
                onPressed: () async {
                  bool conf = await AppService.confirmDialog(
                    'resign'.tr,
                    Text('confirmResign'.tr),
                  );
                  if (!conf) return;
                  try {
                    await wc.resign();
                  } catch (e) {
                    AppService.error('error'.tr, e);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

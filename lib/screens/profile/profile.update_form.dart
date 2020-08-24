import 'package:flutter/material.dart';
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
            decoration: InputDecoration(hintText: 'nickname'),
            controller: nickname,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'first name'),
            controller: firstname,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'last name'),
            controller: lastname,
          ),
          RaisedButton(
            onPressed: () async {
              try {
                await wc.profileUpdate({
                  'nickname': nickname,
                  'first_name': firstname,
                  'last_name': lastname,
                });
              } catch (e) {
                // TODO
                // AppService.error(e);
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}

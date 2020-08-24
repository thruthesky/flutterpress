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
  TextEditingController firstNameController;

  _onSubmit() {
    final String firstName = firstNameController.value.text;
    wc.profileUpdate(firstName: firstName).then((user) {
      Get.snackbar('Profile', 'Profile updated!');
    }).catchError((err) {
      Get.snackbar(
        'Profile Update Failed',
        '$err',
      );
    });
  }

  @override
  void initState() {
    firstNameController = TextEditingController(text: wc.user.firstName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'first name'),
            controller: firstNameController,
          ),
          RaisedButton(
            onPressed: _onSubmit,
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}

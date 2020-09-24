import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:flutterpress/widgets/commons/common.form_submit_button.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:get/get.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/country_code_selector.dart';

class PhoneAuthForm extends StatefulWidget {
  @override
  _PhoneAuthFormState createState() => _PhoneAuthFormState();
}

class _PhoneAuthFormState extends State<PhoneAuthForm> {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  bool loading = false;

  String countryCode = '+82';
  String get internationalNo => '$countryCode${_phoneController.text}';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(AppService.wc.user.sessionId);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select country code',
            style: TextStyle(
                color: Color(0xff5f5f5f), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 6),
          CountryCodeSelector(
            enabled: !loading,
            initialSelection: countryCode,
            onChanged: (_) {
              countryCode = _.dialCode;
            },
          ),
          SizedBox(height: 50),
          Text('mobileNo'.tr),
          AppTextInputField(
            contentSize: 23,
            contentPadding: EdgeInsets.symmetric(vertical: xs),
            inputType: TextInputType.phone,
            inputAction: TextInputAction.done,
            controller: _phoneController,
            hintText: '000-000-000',
            validator: (str) {
              if (isEmpty(str)) return 'err_number_empty'.tr;
            },
          ),
          SizedBox(height: xxl),
          if (loading) Center(child: CommonSpinner()),
          if (!loading)
          CommonFormSubmitButton(
            text: 'sendCode'.tr.toUpperCase(),
            onPressed: () => verifyPhoneNumber(),
          ),
        ],
      ),
    );
  }

  verifyPhoneNumber() {
    if (isEmpty(countryCode)) {
      AppService.alertError('err_countryCode_empty'.tr);
      return;
    }

    if (_formKey.currentState.validate()) {
      loading = true;
      setState(() {});

      _fbAuth.verifyPhoneNumber(
        phoneNumber: internationalNo,

        /// this will only be called after the automatic code retrieval is performed.
        /// some phone may have the automatic code retrieval. some may not.
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('automatic  code retrieval from received sms happened!');
          // verifyCode();
        },

        /// called whenever error happens
        verificationFailed: (FirebaseAuthException e) {
          AppService.alertError(e);
        },

        /// called after the user submitted the phone number.
        codeSent: (String verID, [int forceResendToken]) {
          loading = false;
          setState(() {});

          Get.toNamed(Routes.phoneAuthCode, arguments: {
            'mobileNo': internationalNo,
            'sessionID': verID,
          });
        },

        codeAutoRetrievalTimeout: (String verID) {
          print('codeAutoRetrievalTimeout');
          print('$verID');
        },
      );
    }
  }
}

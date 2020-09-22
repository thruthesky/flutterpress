import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:get/get.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/country_code_selector.dart';

class PhoneAuthForm extends StatefulWidget {
  @override
  _PhoneAuthFormState createState() => _PhoneAuthFormState();
}

class _PhoneAuthFormState extends State<PhoneAuthForm> {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isCodeSent = false;

  int resendToken;
  String verificationID;
  String countryCode = '+82';

  String get internationalNo => '$countryCode${_phoneController.text}';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(wc.user.sessionId);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select country code'),
              CountryCodeSelector(
                enabled: !isCodeSent,
                initialSelection: countryCode,
                onChanged: (_) {
                  countryCode = _.dialCode;
                },
              ),
              AppTextInputField(
                enabled: !isCodeSent,
                inputType: TextInputType.phone,
                inputAction: TextInputAction.done,
                controller: _phoneController,
                labelText: 'mobileNo'.tr,
                validator: (str) {
                  if (isEmpty(str)) return 'err_number_empty'.tr;
                },
              ),
              SizedBox(height: isCodeSent ? 20 : 10),
              if (isCodeSent)
                AppTextInputField(
                  inputType: TextInputType.phone,
                  inputAction: TextInputAction.done,
                  controller: _codeController,
                  labelText: 'verificationCode'.tr,
                  validator: (str) {
                    if (isEmpty(str)) return 'err_verificationCode_empty'.tr;
                  },
                ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    isCodeSent ? 'Verify Code' : 'Send Code',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  color: Colors.blueAccent,
                  onPressed: isCodeSent
                      ? () => verifyCode()
                      : () => verifyPhoneNumber(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  verifyCode() async {
    if (_formKey.currentState.validate()) {
      try {
        await wc.phoneAuthCodeVerification(
          sessionID: verificationID,
          verificationCode: _codeController.text,
          mobileNo: internationalNo,
        );
        wc.user.mobile = internationalNo;
        Get.offAllNamed(Routes.profile);
      } catch (e) {
        AppService.alertError(e);
      }
    }
  }

  verifyPhoneNumber() {
    if (isEmpty(countryCode)) {
      AppService.alertError('err_countryCode_empty'.tr);
      return;
    }

    // print('phoneNumber');
    // print(internationalNo);
    if (_formKey.currentState.validate()) {
      _fbAuth.verifyPhoneNumber(
        phoneNumber: internationalNo,

        /// this will only be called after the automatic code retrieval is performed.
        /// some phone may have the automatic code retrieval. some may not.
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(
            'automatic verification code retrieval from received sms happened!',
          );
          verifyCode();
        },

        /// called whenever error happens
        verificationFailed: (FirebaseAuthException e) {
          // print('verificationFailed');
          // print(e);
          AppService.alertError(e);
        },

        /// called after the user submitted the phone number.
        codeSent: (String verId, [int forceResendToken]) {
          // print('codesent!!');
          // print('verification ID: $verId');
          // print('forceSend: $forceResend');

          verificationID = verId;
          resendToken = forceResendToken;
          setState(() {
            isCodeSent = true;
          });
        },

        codeAutoRetrievalTimeout: (String verID) {
          // print('codeAutoRetrievalTimeout');
          // print('$verID');
          verificationID = verID;
        },
      );
    }
  }
}

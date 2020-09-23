import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:flutterpress/widgets/commons/common.button.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:flutterpress/widgets/or_divider.dart';
import 'package:get/get.dart';

class PhoneAuthCodeForm extends StatefulWidget {
  final String mobileNo;
  final String sessionID;
  PhoneAuthCodeForm({this.mobileNo, this.sessionID});

  @override
  _PhoneAuthCodeFormState createState() => _PhoneAuthCodeFormState();
}

class _PhoneAuthCodeFormState extends State<PhoneAuthCodeForm> {

  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  bool isFormSubmitted = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('inputCode'.tr),
            AppTextInputField(
              contentSize: xl,
              contentPadding: EdgeInsets.symmetric(vertical: sm),
              inputType: TextInputType.phone,
              inputAction: TextInputAction.done,
              controller: _codeController,
              hintText: 'XXXXXX',
              autoValidate: isFormSubmitted,
              validator: (str) {
                if (isEmpty(str)) return 'err_number_verification_code'.tr;
              },
            ),
            SizedBox(height: xxl),
            if (loading) Center(child: CommonSpinner()),
            if (!loading) ...[
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'sendCode'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  color: Colors.blue[500],
                  onPressed: () => verifyCode(),
                ),
              ),
              SizedBox(height: xxl),
              OrDivider(),
              SizedBox(height: md),
              Row(
                children: [
                  CommonButton(
                    child: Text(
                      'resendCode'.tr,
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                    onTap: loading
                        ? null
                        : () {
                            print('TODO: resend code');
                          },
                  ),
                  Spacer(),
                  CommonButton(
                    child: Text(
                      'changeNumber'.tr,
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                    onTap: loading
                        ? null
                        : () {
                            Get.back();
                          },
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }

  verifyCode() async {
    isFormSubmitted = true;
    setState(() {});

    if (_formKey.currentState.validate()) {
      loading = true;
      setState(() {});

      try {
        await AppService.wc.phoneAuthCodeVerification(
          sessionID: widget.sessionID,
          verificationCode: _codeController.text,
          mobileNo: widget.mobileNo,
        );
        AppService.wc.updateUserMobile(widget.mobileNo);
        loading = true;
        setState(() {});
        Get.offAllNamed(Routes.profile);
      } catch (e) {
        loading = false;
        setState(() {});
        AppService.alertError(e);
      }
    }
  }
}

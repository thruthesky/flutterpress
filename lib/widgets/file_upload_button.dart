import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.globals.dart';
import 'package:get/get.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadButton extends StatefulWidget {
  final Function onPicked;

  FileUploadButton({this.onPicked(File file)});

  @override
  _FileUploadButtonState createState() => _FileUploadButtonState();
}

class _FileUploadButtonState extends State<FileUploadButton> {
  final options = [
    {
      'text': 'camera'.tr,
      'result': ImageSource.camera,
    },
    {
      'text': 'gallery'.tr,
      'result': ImageSource.gallery,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(FontAwesomeIcons.camera),
        onPressed: () async {
          File file;
          var source = await Get.bottomSheet(
            CustomBottomSheet(
              title: 'Choose source',
              options: options,
            ),
            backgroundColor: Colors.white,
          );

          print(source);
          if (!isEmpty(source)) {
            file = await AppService.pickImage(context, source);
            if (isEmpty(file)) return;
            if (widget.onPicked != null) widget.onPicked(file);
          }
        },
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> options;

  CustomBottomSheet({@required this.title, @required this.options});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: context.height * .4,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(md),
              child: Text(title),
            ),
            for (var option in options)
              FlatButton(
                child: Text(option['text']),
                onPressed: () {
                  Get.back(result: option['result']);
                },
              ),
            FlatButton(
              child: Text('cancel'.tr),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}

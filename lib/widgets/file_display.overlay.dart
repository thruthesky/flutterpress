
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/widgets/commons/common.image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileDisplayOverlay extends StatefulWidget {
  final List<FileModel> files;
  final int index;

  FileDisplayOverlay({this.files, this.index = 0});

  @override
  _FileDisplayOverlayState createState() => _FileDisplayOverlayState();
}

class _FileDisplayOverlayState extends State<FileDisplayOverlay> {
  int index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  previous() {
    index--;
    if (index < 0) index = widget.files.length - 1;
    setState(() {});
  }

  next() {
    index++;
    if (index > widget.files.length - 1) index = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(sm),
        child: Stack(
          children: [
            Positioned(
              child: GestureDetector(
                child: Icon(FontAwesomeIcons.timesCircle, color: Colors.white),
                onTap: () => Get.back(),
              ),
              right: 0,
              top: xxl,
            ),
            Center(
              child: CommonImage(widget.files[index].url),
            ),
            if (widget.files.length > 1)
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: sm),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        FontAwesomeIcons.arrowAltCircleLeft,
                        color: Colors.white,
                      ),
                      onTap: () => previous(),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Icon(
                        FontAwesomeIcons.arrowAltCircleRight,
                        color: Colors.white,
                      ),
                      onTap: () => next(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/widgets/commons/common.image.dart';
import 'package:flutterpress/widgets/file_display.overlay.dart';
import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FileDisplay extends StatelessWidget {
  final List<FileModel> files;
  final bool inEdit;
  final Function onFileDeleted;

  FileDisplay(
    this.files, {
    this.inEdit = false,
    this.onFileDeleted(FileModel file),
  });

  onDeleteTapped(FileModel file) {
    AppService.confirmDialog(
      'deleteImage'.tr,
      Text('confirmDelete'.tr),
      onConfirm: () async {
        try {
          await AppService.wc.fileDelete({'ID': file.id});
          onFileDeleted(file);
        } catch (e) {
          AppService.error(e);
        }
      },
    );
  }

  onImageTap({int index = 0}) {
    Get.dialog(FileDisplayOverlay(files: files, index: index));
  }

  @override
  Widget build(BuildContext context) {
    return (files == null || files.length < 1)
        ? SizedBox.shrink()
        : Column(
            children: [
              SizedBox(height: sm),
              ImageStack(
                photoUrl: files[0].thumbnailUrl,
                inEdit: inEdit,
                withHeight: false,
                onDeleteTap: () => onDeleteTapped(files[0]),
                onImageTap: () => onImageTap(),
              ),
            ],
          );
  }
}

class ImageStack extends StatelessWidget {
  final String photoUrl;
  final bool inEdit;
  final Function onDeleteTap;
  final Function onImageTap;

  final bool withHeight;

  final int moreImageCount;

  ImageStack({
    this.photoUrl,
    this.inEdit,
    this.onDeleteTap,
    this.onImageTap,
    this.withHeight = true,
    this.moreImageCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(children: [
        CommonImage(
          photoUrl,
          height: withHeight ? 100 : null,
        ),
        if (inEdit)
          Positioned(
            top: xs,
            right: xs,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.trash, color: Colors.red),
              onPressed: onDeleteTap,
            ),
          ),
        if (moreImageCount != null)
          Container(
            color: Colors.black45,
            child: Center(
              child: Text(
                '+$moreImageCount',
                style: TextStyle(color: Colors.white, fontSize: lg),
              ),
            ),
          )
      ]),
      onTap: onImageTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/widgets/commons/common.image.dart';
import 'package:get/get.dart';
import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// TODO: make image tappable and show in large view.
///
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
    AppService.confirmDialog('deleteImage', Text('confirmDelete'.tr),
        onConfirm: () async {
      try {
        await AppService.wc.fileDelete({'ID': file.id});
        onFileDeleted(file);
      } catch (e) {
        AppService.error(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (files == null || files.length < 1) return SizedBox.shrink();

    if (files.length > 1)
      return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        crossAxisCount: 3,
        shrinkWrap: true,
        children: [
          /// show only six image if images count exceed 6
          if (files.length > 6)
            for (var i = 1; i <= 6; i++)
              ImageStack(
                photoUrl: files[i - 1].thumbnailUrl,
                inEdit: inEdit,
                onDeleteTap: () => onDeleteTapped(files[i - 1]),
              ),

          /// show all image if image is below or equal 6
          if (files.length <= 6)
            for (var file in files)
              ImageStack(
                photoUrl: file.thumbnailUrl,
                inEdit: inEdit,
                onDeleteTap: () => onDeleteTapped(file),
              ),
        ],
      );

    /// show big image if there is only 1 to show
    return ImageStack(
      photoUrl: files[0].thumbnailUrl,
      inEdit: inEdit,
      withHeight: false,
      onDeleteTap: () => onDeleteTapped(files[0]),
    );
  }
}

class ImageStack extends StatelessWidget {
  final String photoUrl;
  final bool inEdit;
  final Function onDeleteTap;

  final bool withHeight;

  ImageStack({
    this.photoUrl,
    this.inEdit,
    this.onDeleteTap,
    this.withHeight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
    ]);
  }
}

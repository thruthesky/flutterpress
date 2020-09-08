import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.globals.dart';
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

  Widget buildImageStack(FileModel file) {
    return Stack(children: [
      CachedNetworkImage(
        imageUrl: file.thumbnailUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      if (inEdit)
        Positioned(
          top: xs,
          right: xs,
          child: IconButton(
              icon: Icon(FontAwesomeIcons.trash, color: Colors.red),
              onPressed: () {
                AppService.confirmDialog(
                    'deleteImage', Text('confirmDelete'.tr),
                    onConfirm: () async {
                  try {
                    await AppService.wc.fileDelete({'ID': file.id});
                    onFileDeleted(file);
                  } catch (e) {
                    AppService.error(e);
                  }
                });
              }),
        ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (files == null || files.length < 1) return SizedBox.shrink();

    if (files.length > 1)
      return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        crossAxisCount: 3,
        shrinkWrap: true,
        children: [
          /// show only six image if images count exceed 6
          if (files.length > 6)
            for (var i = 1; i <= 6; i++)
              buildImageStack(
                files[i - 1],
              ),

          /// show all image if image is below or equal 6
          if (files.length <= 6)
            for (var file in files)
              buildImageStack(
                file,
              )
        ],
      );

    /// show big image if there is only 1 to show
    return buildImageStack(files[0]);
  }
}

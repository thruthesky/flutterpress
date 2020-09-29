import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/widgets/file_display.overlay.dart';
import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FileDisplay extends StatelessWidget {
  final List<FileModel> files;
  final bool inEdit;
  final Function onFileDeleted;

  final int filesToShow;

  int get viewLimit {
    if (inEdit) return files.length;
    return 4;
  }

  FileDisplay(
    this.files, {
    this.inEdit = false,
    this.onFileDeleted(FileModel file),
    this.filesToShow = 4,
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
        : StaggeredGridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 6,
            staggeredTiles: [
              const StaggeredTile.count(6, 3.5),
              if (files.length == 2) const StaggeredTile.count(6, 3.5),
              if (files.length == 3) ...[
                const StaggeredTile.count(3, 3),
                const StaggeredTile.count(3, 3),
              ],
              if (files.length >= 4 && !inEdit) ...[
                const StaggeredTile.count(2, 2),
                const StaggeredTile.count(2, 2),
                const StaggeredTile.count(2, 2),
              ],
              if (files.length >= 4 && inEdit)
                for (int i = 0; i < files.length - 1; i++)
                  const StaggeredTile.count(2, 2),
            ],
            children: [
              for (int i = 0; i < files.length; i++)
                if (i < viewLimit) // only show 4 images when not in Edit
                  ImageStack(
                    inEdit: inEdit,
                    photoUrl: files[i].thumbnailUrl,
                    onDeleteTap: () => onDeleteTapped(files[i]),
                    onImageTap: () => onImageTap(index: i),
                    moreImageCount:
                        i == 3 && !inEdit ? files.length - (i + 1)  : null,
                  )
            ],
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            padding: const EdgeInsets.all(0),
          );
  }
}

class ImageStack extends StatelessWidget {
  final String photoUrl;
  final bool inEdit;
  final Function onDeleteTap;
  final Function onImageTap;

  final double height;

  final int moreImageCount;

  ImageStack({
    this.photoUrl,
    this.inEdit,
    this.onDeleteTap,
    this.onImageTap,
    this.height,
    this.moreImageCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(children: [
        CachedNetworkImage(
          imageUrl: photoUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: height,
          fadeInDuration: Duration(milliseconds: 500),
          fadeOutDuration: Duration(milliseconds: 500),
          imageBuilder: (context, provider) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: provider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
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
        if (moreImageCount != null && moreImageCount != 0)
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

import 'package:flutter/material.dart';
import 'package:flutterpress/models/file.model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileDisplay extends StatelessWidget {
  final List<FileModel> files;
  final bool inEdit;
  final Function onDeleteTap;

  FileDisplay(this.files, {this.inEdit = false, this.onDeleteTap(int fileID)});

  @override
  Widget build(BuildContext context) {
    return files != null && files.length > 0
        ? Wrap(children: [
            for (var file in files)
              Stack(children: [
                Image.network(file.thumbnailUrl),
                if (inEdit)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.trash, color: Colors.red),
                      onPressed: () {
                        onDeleteTap(file.id);
                      },
                    ),
                  ),
              ])
          ])
        : SizedBox.shrink();
  }
}

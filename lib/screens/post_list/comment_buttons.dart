import 'package:flutter/material.dart';

class CommentButtons extends StatelessWidget {
  final Function onUpdateTap;
  final Function onDeleteTap;

  CommentButtons({this.onUpdateTap, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RaisedButton(
          child: Text('update'),
          onPressed: onUpdateTap,
        ),
        RaisedButton(
          child: Text('delete'),
          onPressed: onDeleteTap,
        ),
      ],
    );
  }
}

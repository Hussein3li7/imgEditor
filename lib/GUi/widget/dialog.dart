import 'package:flutter/material.dart';

class PermitionDialog extends StatefulWidget {
  String msgTitle, msgContent;
  PermitionDialog({@required this.msgTitle, @required this.msgContent});
  @override
  _PermitionDialogState createState() =>
      _PermitionDialogState(msgTitle: msgTitle, msgContent: msgContent);
}

class _PermitionDialogState extends State<PermitionDialog> {
  String msgTitle, msgContent;
  _PermitionDialogState({@required this.msgTitle, @required this.msgContent});
  Future<void> permitionDialog() async {
    return showDialog(
        context: (context),
        builder: (c) {
          return AlertDialog(
            content: Text('dialog'),
            title: Text('Title'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

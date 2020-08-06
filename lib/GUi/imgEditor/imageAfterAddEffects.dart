import 'dart:io';

import 'package:flutter/material.dart';

class ImageAfterEffects extends StatefulWidget {
  File imageFile;
  ImageAfterEffects({@required this.imageFile});
  @override
  _ImageAfterEffectsState createState() =>
      _ImageAfterEffectsState(imageFile: imageFile);
}

class _ImageAfterEffectsState extends State<ImageAfterEffects> {
  File imageFile;
  _ImageAfterEffectsState({@required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: new Container(
          child: imageFile == null
              ? Center(
                  child: new Text('image not Saved'),
                )
              : Image.file(imageFile),
        ),
      ),
    );
  }
}

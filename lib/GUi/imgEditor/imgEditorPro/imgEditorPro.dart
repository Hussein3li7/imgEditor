import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storesharing/GUi/imgEditor/imgEditorPro/te.dart';

class ImageEditorProClass extends StatefulWidget {
  @override
  _ImageEditorProClassState createState() => _ImageEditorProClassState();
}

class _ImageEditorProClassState extends State<ImageEditorProClass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getimageditor() {
    final geteditimage =
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return ImageEditorPro2(
        appBarColor: Colors.blue,
        bottomBarColor: Colors.blue,
      );
    })).then((geteditimage) {
      if (geteditimage != null) {
        setState(() {
          _image = geteditimage;
        });
      }
    }).catchError((er) {
      print(er);
    });
  }

  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Editor Pro example'),
      ),
      body: _image == null
          ? Center(
              child: RaisedButton(
                onPressed: () {
                  getimageditor();
                },
                child: new Text("Open Editor"),
              ),
            )
          : Center(
              child: Image.file(_image),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () {
          _image = null;
          setState(() {});
        },
      ),
    );
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:painter/painter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:storesharing/model/admobService.dart';

class PaintOnImage extends StatefulWidget {
  File img;
  double imgHieght;
  double imgWidth;
  Uint8List memoryImage;
  PaintOnImage(
      {@required this.img,
      this.memoryImage,
      @required this.imgHieght,
      @required this.imgWidth});
  @override
  _PaintOnImageState createState() => new _PaintOnImageState();
}

class _PaintOnImageState extends State<PaintOnImage> {
  bool _finished;
  PainterController _controller;
//////////////////// code of admob Ads
  InterstitialAd interstitialAd;
  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
    _finished = false;
    _controller = _newController();
    _controller.backgroundColor = Colors.transparent;

    _bannerAd = AdmobService().myBanner
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
    Future.delayed(Duration(seconds: 10), showInterAds);
  }

  void showInterAds() {
    interstitialAd = AdmobService().myInterstitial
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd.dispose();
  }

  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  ScreenshotController screenshotController = new ScreenshotController();

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    actions = <Widget>[
      new IconButton(
          icon: new Icon(
            Icons.undo,
          ),
          tooltip: 'تراجع',
          onPressed: () {
            if (_controller.isEmpty) {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => new Text(
                        'التراجع غير ممكن',
                        textAlign: TextAlign.center,
                      ));
            } else {
              _controller.undo();
            }
          }),
      new IconButton(
          icon: new Icon(Icons.delete),
          tooltip: 'حذف',
          onPressed: _controller.clear),
      new IconButton(
        icon: new Icon(Icons.check),
        onPressed: () async {
          await screenshotController
              .capture(pixelRatio: 2.9)
              .then((imgCaptured) {
            Navigator.pop(context, imgCaptured);
          });
        },
      ),
    ];

    return new Scaffold(
      appBar: new AppBar(
        actions: actions,
        bottom: new PreferredSize(
          child: new DrawBar(_controller),
          preferredSize: new Size(MediaQuery.of(context).size.width, 30.0),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: widget.imgHieght / 1.4,
            maxWidth: widget.imgWidth,
          ),
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 50),
          child: Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.file(
                  widget.img,
                ),
                new Painter(_controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawBar extends StatefulWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  _DrawBarState createState() => _DrawBarState();
}

class _DrawBarState extends State<DrawBar> {
  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  ColorSwatch _mainColor = Colors.blue;
  Color _shadeColor = Colors.blue[800];
  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openFullMaterialColorPicker() async {
    _openDialog(
      "Full Material Color picker",
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: _mainColor,
        onMainColorChange: (color) {
          setState(() {
            widget._controller.drawColor = color;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(
          child: new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return new Container(
                child: new Slider(
                  value: widget._controller.thickness,
                  onChanged: (double value) => setState(() {
                    widget._controller.thickness = value;
                  }),
                  min: 1.0,
                  max: 20.0,
                  activeColor: Colors.white,
                ),
              );
            },
          ),
        ),
        new StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return new RotatedBox(
              quarterTurns: widget._controller.eraseMode ? 2 : 0,
              child: IconButton(
                icon: widget._controller.eraseMode
                    ? Icon(FontAwesomeIcons.eraser)
                    : Icon(Icons.create),
                tooltip: (widget._controller.eraseMode ? 'مسح' : 'كتابة'),
                onPressed: () {
                  setState(() {
                    widget._controller.eraseMode =
                        !widget._controller.eraseMode;
                  });
                },
              ),
            );
          },
        ),
        IconButton(
            icon: Icon(Icons.colorize),
            onPressed: () {
              _openFullMaterialColorPicker();
            })
        //new ColorPickerButton(_controller, false),
      ],
    );
  }
}

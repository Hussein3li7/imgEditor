import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:storesharing/GUi/widget/googleFontList.dart';
import 'package:storesharing/model/admobService.dart';
import 'package:storesharing/provider/provider.dart';
import 'package:wave_slider/wave_slider.dart';

class EditeTextWidget extends StatefulWidget {
  File img;

  EditeTextWidget({
    Key key,
    @required this.img,
  }) : super(key: key);
  @override
  _EditeTextWidgetState createState() => _EditeTextWidgetState(
        img: img,
      );
}

class _EditeTextWidgetState extends State<EditeTextWidget> {
  File img;

  _EditeTextWidgetState({@required this.img});
  double top = 0;
  double left = 0;
  Offset offset = Offset(0, 0);
  ScreenshotController _screenshotController = new ScreenshotController();
  List<Draggable> textListDraggble = [];
  GoogleFonts lableStyle;
  bool showAddTextDialog = false;
  String lableTest = "";
  double _fontSize = 25;
  bool enableTextALignment = false;
  bool showTextALignment = false;
  bool enableImageBoxfit = false;
  bool showImageBoxfit = false;
  @override
  Widget build(BuildContext context) {
    var fontStyle = Provider.of<FontProvider>(context);
    var imgStyle = Provider.of<ImgProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.text_fields),
              onPressed: () {
                setState(() {
                  showAddTextDialog = !showAddTextDialog;
                });
              }),
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                setState(() {
                  showAddTextDialog = true;
                });
                _screenshotController.capture(pixelRatio: 2.9).then((img) {
                  Navigator.pop(context, img);
                });
              }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: <Widget>[
                      Screenshot(
                        controller: _screenshotController,
                        child: Column(
                          // overflow: Overflow.clip,
                          // fit: StackFit.passthrough,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  //right: Radius.circular(20),
                                ),
                              ),
                              child: showAddTextDialog
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showAddTextDialog =
                                              !showAddTextDialog;
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: SelectableText(
                                          '$lableTest',
                                          textAlign: fontStyle.textAlign,
                                          style: TextStyle(
                                            fontFamily: fontStyle.fontFamily,
                                            fontSize: _fontSize,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : TextField(
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: fontStyle.fontFamily,
                                        fontSize: fontStyle.fontSize,
                                      ),
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        hintText: 'اكتب هنا',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        suffix: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showAddTextDialog =
                                                  !showAddTextDialog;
                                            });
                                          },
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          lableTest = text;
                                        });
                                      },
                                    ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: GridView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(20),
                                    ),
                                    child: PhotoView(
                                      imageProvider: FileImage(
                                        img,
                                      ),
                                      //  customSize: Size(imgWidth, imgHeight),
                                      backgroundDecoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      basePosition: Alignment.center,
                                      enableRotation: true,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                          MediaQuery.of(context).size.width + 100,
                          MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: Transform.rotate(
                          angle: 23.55,
                          origin: Offset(-140, 55),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(.5),
                            ),
                            width: 150,
                            height: 50,
                            child: WaveSlider(
                              onChangeEnd: (v) {},
                              displayTrackball: true,
                              color: Colors.white,
                              onChanged: (double dragUpdate) {
                                if (dragUpdate * 50 < 13) {
                                  return;
                                } else {
                                  setState(() {
                                    _fontSize = dragUpdate * 50;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black.withOpacity(.3),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.format_align_justify),
                                      onPressed: () {
                                        setState(() {
                                          showTextALignment = false;
                                          enableTextALignment =
                                              !enableTextALignment;
                                        });
                                      },
                                    ),
                                    AnimatedContainer(
                                      height: enableTextALignment ? 200 : 0,
                                      duration: Duration(milliseconds: 300),
                                      onEnd: () {
                                        setState(() {
                                          showTextALignment =
                                              !showTextALignment;
                                        });
                                      },
                                      child: showTextALignment
                                          ? Column(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.format_align_center,
                                                    size: 17,
                                                  ),
                                                  onPressed: () {
                                                    fontStyle
                                                        .chageFontTextAlign(
                                                            TextAlign.center);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.format_align_left,
                                                    size: 17,
                                                  ),
                                                  onPressed: () {
                                                    fontStyle
                                                        .chageFontTextAlign(
                                                            TextAlign.left);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.format_align_right,
                                                    size: 17,
                                                  ),
                                                  onPressed: () {
                                                    fontStyle
                                                        .chageFontTextAlign(
                                                            TextAlign.right);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.format_align_justify,
                                                    size: 17,
                                                  ),
                                                  onPressed: () {
                                                    fontStyle
                                                        .chageFontTextAlign(
                                                            TextAlign.justify);
                                                  },
                                                ),
                                              ],
                                            )
                                          : Offstage(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GoogleFontList(),
              // Flushbar(
              //   title: "Hey Ninja",
              //   message:
              //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
              //   flushbarPosition: FlushbarPosition.TOP,
              //   flushbarStyle: FlushbarStyle.GROUNDED,
              //   reverseAnimationCurve: Curves.decelerate,
              //   forwardAnimationCurve: Curves.elasticOut,
              //   backgroundColor: Colors.red,
              //   boxShadows: [
              //     BoxShadow(
              //         color: Colors.blue[800],
              //         offset: Offset(0.0, 2.0),
              //         blurRadius: 3.0)
              //   ],
              //   backgroundGradient:
              //       LinearGradient(colors: [Colors.blueGrey, Colors.black]),
              //   isDismissible: false,
              //   duration: Duration(seconds: 4),
              //   icon: Icon(
              //     Icons.check,
              //     color: Colors.greenAccent,
              //   ),
              //   mainButton: FlatButton(
              //     onPressed: () {},
              //     child: Text(
              //       "CLAP",
              //       style: TextStyle(color: Colors.amber),
              //     ),
              //   ),
              //   showProgressIndicator: true,
              //   progressIndicatorBackgroundColor: Colors.blueGrey,
              //   titleText: Text(
              //     "Hello Hero",
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20.0,
              //         color: Colors.yellow[600],
              //         fontFamily: "ShadowsIntoLightTwo"),
              //   ),
              //   messageText: Text(
              //     "You killed that giant monster in the city. Congratulations!",
              //     style: TextStyle(
              //         fontSize: 18.0,
              //         color: Colors.green,
              //         fontFamily: "ShadowsIntoLightTwo"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  } //////////////////// code of admob Ads

  InterstitialAd interstitialAd;
  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
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
}

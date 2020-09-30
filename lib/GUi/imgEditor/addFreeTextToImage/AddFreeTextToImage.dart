import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:storesharing/GUi/widget/googleFontList.dart';
import 'package:storesharing/model/admobService.dart';
import 'package:storesharing/model/colorList.dart';
import 'package:storesharing/provider/freeTextStyleProvider.dart';
import 'package:storesharing/provider/provider.dart';
import 'package:wave_slider/wave_slider.dart';

import 'FreeTextView.dart';

class AddFreeTextToImage extends StatefulWidget {
  File img;
  double imgWidth, imgHie;

  AddFreeTextToImage({this.img, this.imgWidth, this.imgHie});
  @override
  _AddFreeTextToImageState createState() => _AddFreeTextToImageState();
}

class _AddFreeTextToImageState extends State<AddFreeTextToImage> {
  List fontsize = [];
  var howmuchwidgetis = 0;
  List multiwidget = [];
  List<Offset> offsets = [];
  List<String> texts = [];
  List<Color> textColors = [];
  List<String> textFonts = [];
  List<Color> textBgColor = [];
  List<bool> bgColorBool = [];
  List<bool> raduisBool = [];
  String addTextToWidget = "";
  bool showAddTextToWidget = true;
  bool showColorList = false;
  bool borderRaduis = false;
  bool showFontsAndColors = false;
  bool backgroundColor = false;
  double _fontSize = 25;
  Color fontColor = Colors.white;

  TextEditingController textCtrl = new TextEditingController();

  ScreenshotController screenshotController = new ScreenshotController();

  Widget textFeilds(BuildContext c) {
    var fontColor = Provider.of<BackGroundImageColor>(context);
    var fontStyle = Provider.of<FontProvider>(context);
    TextEditingController textCtrl2 =
        new TextEditingController(text: fontStyle.textedite);

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(.6),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextField(
          autofocus: true,
          controller: fontStyle.textedite.isEmpty ? textCtrl : textCtrl2,
          onChanged: (s) {
            fontStyle.textedite = s; //return edtied text(Update text)
          },
          style: TextStyle(
            color: fontColor.fontColor,
            fontFamily: fontStyle.fontFamily,
            fontSize: _fontSize,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor
                ? fontColor.bgColor
                : Colors.transparent, //FIll COlor
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRaduis
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(0),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget waveSlider() {
    return Positioned(
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
    );
  }

  void applyChageToImage() async {
    await screenshotController.capture(pixelRatio: 2.9).then((img) {
      Navigator.pop(context, img);
    });
  }

  @override
  Widget build(BuildContext context) {
    var fontStyle = Provider.of<FontProvider>(context);
    var fontColor = Provider.of<BackGroundImageColor>(context);
    var textProviderStyle = Provider.of<FreeTextStyle>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: showAddTextToWidget
            ? <Widget>[
                showFontsAndColors
                    ? IconButton(
                        icon: Icon(Icons.color_lens),
                        onPressed: () {
                          setState(() {
                            showFontsAndColors = !showFontsAndColors;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.font_download),
                        onPressed: () {
                          setState(() {
                            showFontsAndColors = !showFontsAndColors;
                          });
                        },
                      ),
                IconButton(
                    icon: borderRaduis
                        ? Icon(FontAwesomeIcons.borderStyle)
                        : Icon(FontAwesomeIcons.circle),
                    onPressed: () {
                      setState(() {
                        borderRaduis = !borderRaduis;
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.format_color_fill),
                    onPressed: () {
                      setState(() {
                        backgroundColor = !backgroundColor;
                      });
                    }),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      if (fontStyle.textedite.isEmpty)
                        multiwidget.add(
                          textCtrl.text.trim().toString(),
                        ); // if not edted Text
                      else
                        multiwidget.add(
                          fontStyle.textedite.trim(),
                        ); //user edite text and save it

                      offsets.add(Offset(50, 50));
                      textColors.add(fontColor.fontColor);
                      textFonts.add(fontStyle.fontFamily);
                      textBgColor.add(fontColor.bgColor);
                      fontsize.add(_fontSize);
                      raduisBool.add(borderRaduis);
                      bgColorBool.add(backgroundColor);
                      howmuchwidgetis++;
                      showAddTextToWidget = !showAddTextToWidget;
                      textCtrl.clear();
                    });
                    fontStyle.textedite = "";
                  },
                ),
              ]
            : <Widget>[
                IconButton(
                    icon: Icon(Icons.check), onPressed: applyChageToImage),
                IconButton(
                  icon: Icon(Icons.text_fields),
                  onPressed: () async {
                    setState(
                      () {
                        showAddTextToWidget = !showAddTextToWidget;
                      },
                    );
                  },
                ),
              ],
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 50),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Screenshot(
              controller: screenshotController,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: widget.imgHie / 1.4,
                      maxWidth: widget.imgWidth,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: PhotoView(
                        //customSize: Size(widget.imgWidth, widget.imgHie),
                        enableRotation: true,
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        imageProvider: FileImage(widget.img),
                      ),
                      //   child: Image.file(widget.img),
                    ),
                  ),
                  Stack(
                    children: multiwidget.asMap().entries.map((f) {
                      //  if (f.value.toString().trim().isNotEmpty) {
                      return FreeTextView(
                        left: offsets[f.key].dx,
                        top: offsets[f.key].dy,
                        ontap: () {
                          fontStyle.chageTextEdite(multiwidget[f.key]);
                          multiwidget.removeAt(f.key);
                          textColors.removeAt(f.key);
                          textFonts.removeAt(f.key);
                          fontsize.removeAt(f.key);
                          setState(() {
                            showAddTextToWidget = true;
                          });
                        },
                        showBgColor: bgColorBool[f.key],
                        bgColor: textBgColor[f.key],
                        onpanupdate: (details) {
                          setState(() {
                            offsets[f.key] = Offset(
                              offsets[f.key].dx + details.delta.dx,
                              offsets[f.key].dy + details.delta.dy,
                            );
                          });
                        },
                        raduis: raduisBool[f.key],
                        value: f.value != null
                            ? f.value.toString()
                            : "", // equal "" to dont return null value
                        fontsize: fontsize[f.key].toDouble(),
                        align: TextAlign.center,
                        fontFamily: textFonts[f.key],
                        color: textColors[f.key],
                      );
                    }).toList(),
                  ),
                  // Positioned(
                  //   bottom: 15.0,
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: <Widget>[
                  //       Text('@hussein3li7'),
                  //       SizedBox(
                  //         width: widget.imgWidth / 4,
                  //       ),
                  //       Text('@AppName'),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            showAddTextToWidget ? textFeilds(context) : Offstage(),
            showAddTextToWidget
                ? showFontsAndColors
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GoogleFontList(),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          backgroundColor
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    color: Colors.black.withOpacity(.5),
                                    alignment: Alignment.bottomRight,
                                    child: ListView.builder(
                                      itemCount: allColors.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (c, i) {
                                        return GestureDetector(
                                          onTap: () {
                                            fontColor
                                                .changeBGColor(allColors[i]);
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            margin: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              color: allColors[i],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Offstage(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              color: Colors.black.withOpacity(.5),
                              alignment: Alignment.bottomRight,
                              child: ListView.builder(
                                itemCount: allColors.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (c, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      fontColor.changeFontColor(allColors[i]);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        color: allColors[i],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                : Offstage(),
            showAddTextToWidget ? waveSlider() : Offstage(),
          ],
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

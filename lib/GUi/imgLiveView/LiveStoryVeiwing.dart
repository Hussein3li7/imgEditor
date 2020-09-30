import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:storesharing/model/admobService.dart';
import 'package:storesharing/provider/provider.dart';
import '../../model/colorList.dart';

class LiveStoryVeiwing extends StatefulWidget {
  File img;
  LiveStoryVeiwing({this.img});
  @override
  _LiveStoryVeiwingState createState() => _LiveStoryVeiwingState();
}

class _LiveStoryVeiwingState extends State<LiveStoryVeiwing> {
  ScreenshotController screenshotController = new ScreenshotController();

  TextEditingController postTitleCtrl = new TextEditingController();

  bool showCopyRight = false;

  // Future<void> postTitleDialog() async {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: (context),
  //     builder: (c) {
  //       return CupertinoAlertDialog(
  //         title: Text(
  //           'عنوان المنشور',
  //           style: GoogleFonts.cairo(),
  //         ),
  //         content: CupertinoTextField(
  //           controller: postTitleCtrl,
  //           autofocus: true,
  //           textAlign: TextAlign.right,
  //           style: GoogleFonts.cairo(
  //             color: Colors.white,
  //           ),
  //           minLines: 1,
  //           maxLines: 5,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30),
  //             color: Colors.black38,
  //           ),
  //           keyboardType: TextInputType.text,
  //           placeholder: 'اكتب هنا',
  //         ),
  //         actions: <Widget>[
  //           RaisedButton(
  //             onPressed: () async {
  //               setState(() {
  //                 showCopyRight = true;
  //               });
  //               await screenshotController
  //                   .capture(pixelRatio: 2.9)
  //                   .then((img) async {
  //                 SocialShare.shareOptions(
  //                   '${postTitleCtrl.text}',
  //                   imagePath: img.path,
  //                 );
  //               });
  //             },
  //             child: Text('مشاركة'),
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('الغاء'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  InterstitialAd interstitialAd;
  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();

    _bannerAd = AdmobService().myBanner
      ..load()
      ..show(anchorType: AnchorType.top);

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

  @override
  Widget build(BuildContext context) {
    var bgImageColor = Provider.of<BackGroundImageColor>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bgImageColor.topColor,
                bgImageColor.buttomColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        'شكل الصورة في ستوري فيسوك و انستغرام',
                        style: GoogleFonts.cairo(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListView.builder(
                      itemCount: allColors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i) {
                        return GestureDetector(
                          onTap: () {
                            List c = allColors[i].toString().split("0xff");
                            List colorStr =
                                c[c.length - 1].toString().split(")");

                            bgImageColor.chageTopBgColor(
                              allColors[i],
                            );

                            bgImageColor.chageTopStringColor(colorStr[0]);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
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
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Screenshot(
                      controller: screenshotController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: <Widget>[
                                  Image.file(widget.img),
                                  Positioned(
                                    bottom: 0,
                                    right: 20,
                                    child: Text(
                                      "معدل القصص",
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            blurRadius: 2,
                                            offset: Offset(1, .2),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 20,
                                    child: Text(
                                      "@hussein3li7",
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            blurRadius: 2,
                                            offset: Offset(1, .2),
                                          )
                                        ],
                                      ),
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
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListView.builder(
                        itemCount: allColors.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) {
                          return GestureDetector(
                            onTap: () {
                              List c = allColors[i].toString().split("0xff");
                              List colorStr =
                                  c[c.length - 1].toString().split(")");

                              bgImageColor.chageButtomBgColor(
                                allColors[i],
                              );
                              bgImageColor.chageButtomStringColor(
                                colorStr[0],
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
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
                        }),
                  ),
                ),
                // RaisedButton(
                //   onPressed: () async {
                //     SocialShare.shareInstagramStorywithBackground(
                //         widget.img.path,
                //         bgImageColor.topColorStringForStory,
                //         bgImageColor.buttonColorStringForStory,
                //         "https:instagram.com/hussien3li7",
                //         backgroundImagePath:  widget.img.path,
                //         );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CircleFloatingButton.floatingActionButton(
        key: key03,
        items: <Widget>[
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: Colors.indigo,
            onPressed: () async {
              setState(() {
                showCopyRight = true;
              });
              await screenshotController.capture(pixelRatio: 2.9).then(
                (img) async {
                  SocialShare.shareInstagramStory(
                    img.path,
                    "#${bgImageColor.topColorStringForStory}",
                    "#${bgImageColor.buttonColorStringForStory}",
                    "https:/instagram.com/hussein3li7",
                  );
                },
              );
            },
            child: Icon(FontAwesomeIcons.instagram),
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: Colors.yellow,
            onPressed: () async {
              setState(() {
                showCopyRight = true;
              });
              await screenshotController
                  .capture(pixelRatio: 2.9)
                  .then((img) async {
                SocialShare.shareOptions(
                  '',
                  imagePath: img.path,
                );
              });
            },
            child: Icon(FontAwesomeIcons.shareAltSquare),
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: Colors.blue,
            onPressed: () async {
              setState(() {
                showCopyRight = true;
              });
              await screenshotController
                  .capture(pixelRatio: 2.9)
                  .then((img) async {
                SocialShare.shareFacebookStory(
                  img.path,
                  "#${bgImageColor.topColorStringForStory}",
                  "#${bgImageColor.buttonColorStringForStory}",
                  "https://www.facebook.com/dialog/share?",
                );
              });
            },
            child: Icon(
              FontAwesomeIcons.facebook,
            ),
          ),
        ],
        color: Colors.blue,
        icon: Icons.share,
        duration: Duration(milliseconds: 400),
        curveAnim: Curves.ease,
        useOpacity: true,
      ),
      // floatingActionButton: ShareButton(
      //   img: widget.img,
      //   topColor: bgImageColor.topColorStringForStory,
      //   buttomColor: bgImageColor.buttonColorStringForStory,
      // ),
    );
  }

  GlobalKey<CircleFloatingButtonState> key03 =
      GlobalKey<CircleFloatingButtonState>();
}

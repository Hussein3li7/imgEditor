import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:storesharing/GUi/widget/googleFontList.dart';
import 'package:storesharing/GUi/widget/shareButton.dart';
import 'package:storesharing/provider/provider.dart';
import 'package:wave_slider/wave_slider.dart';

class EditeTextWidget extends StatefulWidget {
  File img;
  double imgWidth;
  double imgHeight;
  EditeTextWidget(
      {Key key,
      @required this.img,
      @required this.imgWidth,
      @required this.imgHeight})
      : super(key: key);
  @override
  _EditeTextWidgetState createState() =>
      _EditeTextWidgetState(img: img, imgHeight: imgHeight, imgWidth: imgWidth);
}

class _EditeTextWidgetState extends State<EditeTextWidget> {
  File img;
  double imgWidth;
  double imgHeight;

  _EditeTextWidgetState(
      {@required this.img, @required this.imgWidth, @required this.imgHeight});
  double top = 0;
  double left = 0;
  Offset offset = Offset(0, 0);
  ScreenshotController _screenshotController = new ScreenshotController();
  List<Draggable> textListDraggble = [];
  GoogleFonts lableStyle;
  bool showAddTextDialog = false;
  String lableTest = "";
  double _fontSize = 25;
  bool showUserName = false;
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
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topCenter,
                child: Stack(
                  children: <Widget>[
                    Screenshot(
                      controller: _screenshotController,
                      child: Column(
                        // overflow: Overflow.clip,
                        // fit: StackFit.passthrough,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            width: widget.imgWidth / 1.3,
                            child: showAddTextDialog
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showAddTextDialog = !showAddTextDialog;
                                      });
                                    },
                                    child: Container(
                                      width: widget.imgWidth / 1.3,
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
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'اكتب هنا',
                                      hintStyle: TextStyle(color: Colors.grey),
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
                          Expanded(
                            child: Container(
                              width: widget.imgWidth / 1.3,
                              height: widget.imgHeight / 1.3,
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
                                    child: Image.file(
                                      img,
                                      fit: imgStyle.imgBoxFit,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          showUserName
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Transform.translate(
                                    offset: Offset(0, -130),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('@Hussein3li7'),
                                        Text('@AppName'),
                                      ],
                                    ),
                                  ),
                                )
                              : Offstage(),

                          // ClipRRect(
                          //   borderRadius: BorderRadius.vertical(
                          //     bottom: Radius.circular(20),
                          //     //right: Radius.circular(20),
                          //   ),
                          //   child: Image.file(
                          //     img,
                          //     width: widget.imgWidth / 1.3,
                          //     height: widget.imgHeight / 1.3,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),

                          // Container(
                          //   alignment: Alignment.topLeft,
                          //   margin: EdgeInsets.all(30),
                          //   height: 300,
                          //   width: MediaQuery.of(context).size.width,
                          //   color: Colors.indigo.shade100,
                          //   child: Draggable(
                          //     child: Container(
                          //       padding: EdgeInsets.only(top: top, left: left),
                          //       child: DragItem(),
                          //     ),
                          //     feedback: Container(
                          //       padding: EdgeInsets.only(top: top, left: left),
                          //       child: DragItem(),
                          //     ),
                          //     childWhenDragging: Container(
                          //       padding: EdgeInsets.only(top: top, left: left),
                          //       child: DragItem(),
                          //     ),
                          //     onDragCompleted: () {},
                          //     onDragEnd: (drag) {
                          //       setState(() {
                          //         if ((top + drag.offset.dy) > (300.0 - 30.0)) {
                          //           top = (300.0 - 30.0);
                          //         } else if ((top + drag.offset.dy - 30.0) < 0.0) {
                          //           top = 0;
                          //         } else {
                          //           top = top + drag.offset.dy - 30.0;
                          //         }
                          //         if ((left + drag.offset.dx) >
                          //             (MediaQuery.of(context).size.width - 30.0)) {
                          //           left =
                          //               (MediaQuery.of(context).size.width - 30.0);
                          //         } else if ((left + drag.offset.dx - 30.0) < 0.0) {
                          //           left = 0;
                          //         } else {
                          //           left = left + drag.offset.dx - 30.0;
                          //         }
                          //       });
                          //     },
                          //   ),
                          // ),
                          // RaisedButton(onPressed: () async {
                          //   await _screenshotController.capture().then((image) async {
                          //     SocialShare.shareInstagramStory(
                          //       image.path,
                          //       "blue",
                          //       "blue",
                          //       "https://deep-link-url",
                          //     ).then((data) {
                          //       print(data);
                          //     });
                          //   });
                          // }),
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
                        alignment: Alignment.topCenter,
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
                                        showTextALignment = !showTextALignment;
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
                                                  fontStyle.chageFontTextAlign(
                                                      TextAlign.center);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.format_align_left,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  fontStyle.chageFontTextAlign(
                                                      TextAlign.left);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.format_align_right,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  fontStyle.chageFontTextAlign(
                                                      TextAlign.right);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.format_align_justify,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  fontStyle.chageFontTextAlign(
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
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withOpacity(.3),
                              ),
                              child: Column(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.image_aspect_ratio),
                                    onPressed: () {
                                      setState(() {
                                        showImageBoxfit = false;
                                        enableImageBoxfit = !enableImageBoxfit;
                                      });
                                    },
                                  ),
                                  AnimatedContainer(
                                    height: enableImageBoxfit ? 200 : 0,
                                    duration: Duration(milliseconds: 300),
                                    onEnd: () {
                                      setState(() {
                                        showImageBoxfit = !showImageBoxfit;
                                      });
                                    },
                                    child: showImageBoxfit
                                        ? Column(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.ad,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  imgStyle.chageBoxFItImage(
                                                      BoxFit.fill);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.colorize,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  imgStyle.chageBoxFItImage(
                                                      BoxFit.contain);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.compare,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  imgStyle.chageBoxFItImage(
                                                      BoxFit.cover);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete_sweep,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  imgStyle.chageBoxFItImage(
                                                      BoxFit.none);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _screenshotController.capture().then((img) {
            print(img.path);
            Navigator.pop(context, img);
          });
        },
        child: Text(
          'حفظ',
          style: GoogleFonts.cairo(),
        ),
      ),
    );
  }
}

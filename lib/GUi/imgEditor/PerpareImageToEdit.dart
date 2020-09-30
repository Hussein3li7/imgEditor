import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:screenshot/screenshot.dart';
import 'package:storesharing/GUi/imgEditor/addFreeTextToImage/AddFreeTextToImage.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as imageLib;
import 'package:storesharing/GUi/imgEditor/paintImage/paintOnImage.dart';
import 'package:storesharing/GUi/imgLiveView/LiveStoryVeiwing.dart';
import 'package:storesharing/model/admobService.dart';

import 'AddFilterToImage.dart';
import 'addTitleToImage/addTitleToImage.dart';

class PerpareImageToEdit extends StatefulWidget {
  File img;
  Uint8List memoryImg;
  PerpareImageToEdit({@required this.img, this.memoryImg});
  @override
  _PerpareImageToEditState createState() => _PerpareImageToEditState(img: img);
}

class _PerpareImageToEditState extends State<PerpareImageToEdit> {
  File img;
  _PerpareImageToEditState({@required this.img});

  Offset offset = Offset(0, 0);
  ScreenshotController _screenshotController = new ScreenshotController();
  double top = 0;
  double left = 0;
  int imgWidth, imgHeight;
  String fileName;
  List<Filter> filters = presetFiltersList;
  bool showEdtedImage = false;

  void getImageInfo() async {
    final imgFIle = await ImageSizGetter.getSize(img);
    imgWidth = imgFIle.width;
    imgHeight = imgFIle.height;
    print(imgWidth);
    print(imgHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                await ImageGallerySaver.saveFile(img.path).then((_) {
                  print("Done Save");
                });
                // await _screenshotController
                //     .capture(pixelRatio: 2.9)
                //     .then((capturedImage) async {
                //   await ImageGallerySaver.saveFile(capturedImage.path)
                //       .then((save) {
                //     print('Image saved ${save.toString()}');
                //   });
                // });
              }),
        ],
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.file_download),
        //       onPressed: () async {
        //         // await ImageGallerySaver.saveImage(widget.memoryImg)
        //         //     .then((value) {
        //         //   print("DOne");
        //         // });
        //         await _screenshotController
        //             .capture(pixelRatio: 2.9)
        //             .then((capturedImage) async {
        //           await ImageGallerySaver.saveFile(capturedImage.path)
        //               .then((save) {
        //             print('Image saved ${save.toString()}');
        //           });
        //         });
        //       }),
        //   IconButton(
        //       icon: Icon(FontAwesomeIcons.paintBrush),
        //       onPressed: () async {
        //         await _screenshotController
        //             .capture(pixelRatio: 2.9)
        //             .then((capturedImg) async {
        //           File imgCaptured = await Navigator.push(
        //             context,
        //             CupertinoPageRoute(
        //               builder: (c) => PaintOnImage(
        //                 img: capturedImg,
        //                 memoryImage: widget.memoryImg,
        //               ),
        //             ),
        //           );
        //           if (imgCaptured != null) {
        //             setState(() {
        //               img = imgCaptured;
        //               showEdtedImage = true;
        //             });
        //           }
        //         });
        //       }),
        //   IconButton(
        //       icon: Icon(Icons.text_fields),
        //       onPressed: () async {
        //         File edtiedImage = await Navigator.push(
        //           context,
        //           CupertinoPageRoute(
        //             builder: (c) => EditeTextWidget(
        //               img: img,
        //             ),
        //           ),
        //         );
        //         if (edtiedImage != null) {
        //           setState(() {
        //             img = edtiedImage;
        //             showEdtedImage = true;
        //           });
        //         }
        //       }),
        //   IconButton(
        //       icon: Icon(Icons.photo_filter),
        //       onPressed: () async {
        //         await _screenshotController
        //             .capture(pixelRatio: 2.9)
        //             .then((imgg) async {
        //           fileName = p.basename(imgg.path);
        //           var image = imageLib.decodeImage(imgg.readAsBytesSync());
        //           image = imageLib.copyResize(image, width: 1000);
        //           File imgFIle = await Navigator.push(
        //             context,
        //             new CupertinoPageRoute(
        //               builder: (context) => new PhotoSelectorToTryFilter(
        //                 image: image,
        //                 filters: presetFiltersList,
        //                 filename: fileName,
        //                 loader: Center(child: CircularProgressIndicator()),
        //                 fit: BoxFit.contain,
        //               ),
        //             ),
        //           );
        //           if (imgFIle != null) {
        //             setState(() {
        //               img = imgFIle;
        //               showEdtedImage = true;
        //             });
        //           }
        //         });
        //       }),
        //   IconButton(
        //       icon: Icon(Icons.text_format),
        //       onPressed: () async {
        //         File editedImage = await Navigator.push(
        //           context,
        //           CupertinoPageRoute(
        //             builder: (context) => AddFreeTextToImage(
        //               img: img,
        //               imgHie: imgHeight.toDouble(),
        //               imgWidth: imgWidth.toDouble(),
        //             ),
        //           ),
        //         );
        //         if (editedImage != null) {
        //           setState(() {
        //             img = editedImage;
        //             showEdtedImage = true;
        //           });
        //         }
        //       }),
        //   IconButton(
        //     icon: Icon(Icons.live_tv),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         CupertinoPageRoute(
        //           builder: (c) => LiveStoryVeiwing(
        //             img: img,
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     color: Colors.red,
            //     child: Text(
            //       'data',
            //     ),
            //   ),
            // ),
            Expanded(
              child: Container(
                color: Colors.black26,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            img,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: 60),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black26,

                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(60),
                //   topRight: Radius.circular(60),
                // ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () async {
                          File imgCaptured = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (c) => PaintOnImage(
                                img: img,
                                imgHieght: imgHeight.toDouble(),
                                imgWidth: imgWidth.toDouble(),
                              ),
                            ),
                          );
                          if (imgCaptured != null) {
                            File imgBeforEdit = img;
                            setState(() {
                              img = imgCaptured;
                            });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              child: Icon(FontAwesomeIcons.paintBrush),
                            ),
                            Text('رسم'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () async {
                          File edtiedImage = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (c) => EditeTextWidget(
                                img: img,
                              ),
                            ),
                          );
                          if (edtiedImage != null) {
                            setState(() {
                              img = edtiedImage;
                            });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.text_fields),
                            ),
                            Text('اضافة عنوان'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () async {
                          fileName = p.basename(img.path);
                          var image =
                              imageLib.decodeImage(img.readAsBytesSync());
                          image = imageLib.copyResize(image, width: 600);
                          File imgFIle = await Navigator.push(
                            context,
                            new CupertinoPageRoute(
                              builder: (context) =>
                                  new PhotoSelectorToTryFilter(
                                image: image,
                                filters: presetFiltersList,
                                filename: fileName,
                                loader:
                                    Center(child: CircularProgressIndicator()),
                                fit: BoxFit.contain,
                              ),
                            ),
                          );

                          if (imgFIle != null) {
                            setState(() {
                              img = imgFIle;
                            });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.photo_filter),
                            ),
                            Text('اضافة فلتر'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () async {
                          File editedImage = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddFreeTextToImage(
                                img: img,
                                imgHie: imgHeight.toDouble(),
                                imgWidth: imgWidth.toDouble(),
                              ),
                            ),
                          );
                          if (editedImage != null) {
                            setState(() {
                              img = editedImage;
                            });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.text_format),
                            ),
                            Text('اضافة نص'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (c) => LiveStoryVeiwing(
                                img: img,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              child: Icon(FontAwesomeIcons.shareAlt),
                            ),
                            Text('مشاركة'),
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

      // bottomNavigationBar: Container(
      //   child: ListView.builder(
      //       itemCount: 30,
      //       scrollDirection: Axis.horizontal,
      //       itemBuilder: (c, i) {
      //         return CircleAvatar(
      //           child: Text('1'),
      //         );
      //       }),
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       CupertinoPageRoute(
      //         builder: (c) => LiveStoryVeiwing(
      //           img: img,
      //         ),
      //       ),
      //     );
      //   },
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Icon(Icons.share),
      //       Text('مشاركة'),
      //     ],
      //   ),
      // )

      //  floatingActionButtonLocation: FloatingActionButtonLocation.,
    );
  } //////////////////// code of admob Ads

  InterstitialAd interstitialAd;
  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
    getImageInfo();
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

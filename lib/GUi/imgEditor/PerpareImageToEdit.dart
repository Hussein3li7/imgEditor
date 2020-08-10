import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:storesharing/GUi/imgEditor/addFreeTextToImage/AddFreeTextToImage.dart';
import 'package:storesharing/GUi/imgEditor/editedText/editeTextWidget.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as imageLib;
import 'package:storesharing/GUi/imgEditor/paintImage/paintOnImage.dart';
import 'package:storesharing/GUi/imgLiveView/ImgLiveVeiw.dart';
import 'package:storesharing/GUi/widget/shareButton.dart';
import 'package:storesharing/provider/provider.dart';

import 'AddFilterToImage.dart';

class PerpareImageToEdit extends StatefulWidget {
  File img;
  PerpareImageToEdit({@required this.img});
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
  @override
  void initState() {
    super.initState();
    getImageInfo();
  }

  void getImageInfo() async {
    final imgFIle = await ImageSizGetter.getSize(img);
    imgWidth = imgFIle.width;
    imgHeight = imgFIle.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                await _screenshotController
                    .capture()
                    .then((capturedImage) async {
                  await ImageGallerySaver.saveFile(capturedImage.path)
                      .then((save) {
                    print('Image saved ${save.toString()}');
                  });
                });
              }),
          IconButton(
              icon: Icon(FontAwesomeIcons.paintBrush),
              onPressed: () async {
                File imgCaptured = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (c) => PaintOnImage(
                      img: img,
                    ),
                  ),
                );
                if (imgCaptured != null) {
                  File imgBeforEdit = img;
                  setState(() {
                    img = imgCaptured;
                  });
                }
              }),
          IconButton(
              icon: Icon(Icons.text_fields),
              onPressed: () async {
                File edtiedImage = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (c) => EditeTextWidget(
                      img: img,
                      imgHeight: imgHeight.toDouble(),
                      imgWidth: imgWidth.toDouble(),
                    ),
                  ),
                );
                if (edtiedImage != null) {
                  setState(() {
                    img = edtiedImage;
                  });
                }
              }),
          IconButton(
              icon: Icon(Icons.photo_filter),
              onPressed: () async {
                fileName = p.basename(img.path);
                var image = imageLib.decodeImage(img.readAsBytesSync());
                image = imageLib.copyResize(image, width: 600);
                File imgFIle = await Navigator.push(
                  context,
                  new CupertinoPageRoute(
                    builder: (context) => new PhotoSelectorToTryFilter(
                      image: image,
                      filters: presetFiltersList,
                      filename: fileName,
                      loader: Center(child: CircularProgressIndicator()),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
                if (imgFIle != null) {
                  setState(() {
                    img = imgFIle;
                  });
                }
              }),
          IconButton(
              icon: Icon(Icons.text_format),
              onPressed: () async {
                File editedImage = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AddFreeTextToImage(
                      img: img,
                    ),
                  ),
                );
                if (editedImage != null) {
                  setState(() {
                    img = editedImage;
                  });
                }
              }),
          IconButton(
            icon: Icon(Icons.live_tv),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (c) => LiveViewImage(
                    img: img,
                  ),
                ),
              );
            },
          ),
        ],
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
                child: Screenshot(
                  controller: _screenshotController,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(img),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   // padding: EdgeInsets.all(20),
            //   width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     color: Colors.black26,

            //     // borderRadius: BorderRadius.only(
            //     //   topLeft: Radius.circular(60),
            //     //   topRight: Radius.circular(60),
            //     // ),
            //   ),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: <Widget>[
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: GestureDetector(
            //             onTap: () async {
            //               File imgCaptured = await Navigator.push(
            //                 context,
            //                 CupertinoPageRoute(
            //                   builder: (c) => PaintOnImage(
            //                     img: img,
            //                   ),
            //                 ),
            //               );
            //               if (imgCaptured != null) {
            //                 File imgBeforEdit = img;
            //                 setState(() {
            //                   img = imgCaptured;
            //                 });
            //               }
            //             },
            //             child: Column(
            //               children: <Widget>[
            //                 CircleAvatar(
            //                   radius: 30,
            //                   child: Icon(FontAwesomeIcons.paintBrush),
            //                 ),
            //                 Text('رسم'),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: GestureDetector(
            //             onTap: () async {
            //               File edtiedImage = await Navigator.push(
            //                 context,
            //                 CupertinoPageRoute(
            //                   builder: (c) => EditeTextWidget(
            //                     img: img,
            //                     imgHeight: imgHeight.toDouble(),
            //                     imgWidth: imgWidth.toDouble(),
            //                   ),
            //                 ),
            //               );
            //               if (edtiedImage != null) {
            //                 setState(() {
            //                   img = edtiedImage;
            //                 });
            //               }
            //             },
            //             child: Column(
            //               children: <Widget>[
            //                 CircleAvatar(
            //                   radius: 30,
            //                   child: Icon(Icons.text_fields),
            //                 ),
            //                 Text('اضافة عنوان'),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: GestureDetector(
            //             onTap: () async {
            //               fileName = p.basename(img.path);
            //               var image =
            //                   imageLib.decodeImage(img.readAsBytesSync());
            //               image = imageLib.copyResize(image, width: 600);
            //               File imgFIle = await Navigator.push(
            //                 context,
            //                 new CupertinoPageRoute(
            //                   builder: (context) =>
            //                       new PhotoSelectorToTryFilter(
            //                     image: image,
            //                     filters: presetFiltersList,
            //                     filename: fileName,
            //                     loader:
            //                         Center(child: CircularProgressIndicator()),
            //                     fit: BoxFit.contain,
            //                   ),
            //                 ),
            //               );

            //               if (imgFIle != null) {
            //                 setState(() {
            //                   img = imgFIle;
            //                 });
            //               }
            //             },
            //             child: Column(
            //               children: <Widget>[
            //                 CircleAvatar(
            //                   radius: 30,
            //                   child: Icon(Icons.photo_filter),
            //                 ),
            //                 Text('اضافة فلتر'),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: GestureDetector(
            //             onTap: () async {
            //               Navigator.push(
            //                 context,
            //                 CupertinoPageRoute(
            //                   builder: (c) => LiveViewImage(
            //                     img: img,
            //                   ),
            //                 ),
            //               );
            //             },
            //             child: Column(
            //               children: <Widget>[
            //                 CircleAvatar(
            //                   radius: 30,
            //                   child: Icon(Icons.live_tv),
            //                 ),
            //                 Text('عرض الصورة'),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: GestureDetector(
            //             onTap: () {
            //               Navigator.push(
            //                 context,
            //                 CupertinoPageRoute(
            //                   builder: (context) => AddFreeTextToImage(
            //                     img: img,
            //                   ),
            //                 ),
            //               );
            //             },
            //             child: Column(
            //               children: <Widget>[
            //                 CircleAvatar(
            //                   radius: 30,
            //                   child: Icon(Icons.text_format),
            //                 ),
            //                 Text('اضافة نص'),
            //               ],
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
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
      floatingActionButton: ShareButton(
        img: img,
      ),
    );
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/photofilters.dart';
import 'package:storesharing/GUi/about/about.dart';
import 'package:storesharing/GUi/imgEditor/PerpareImageToEdit.dart';
import 'package:storesharing/model/admobService.dart';
import 'package:storesharing/model/permetionsModel.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as imageLib;
import 'package:path_provider/path_provider.dart' as path_provider;

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;
  bool showCompresingImgLoading = false;
  pickImageFromGalary() async {
    await _bannerAd.dispose();
    try {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        setState(() {
          showCompresingImgLoading = true; //to show prepare image loading
        });
        await FlutterImageCompress.compressWithFile(
          imageFile.path,
          minWidth: 2300,
          minHeight: 1500,
          quality: 94,
        ).then(
          (img) {
            setState(() {
              showCompresingImgLoading = false; //to show prepare image loading
            });
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (c) => PerpareImageToEdit(
                  img: imageFile,
                  memoryImg: img,
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  pickImageFromCamera() async {
    try {
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (imageFile != null) {
        setState(() {
          showCompresingImgLoading = true; //to show prepare image loading
        });
        await FlutterImageCompress.compressWithFile(
          imageFile.path,
          minWidth: 2300,
          minHeight: 1500,
          quality: 94,
        ).then(
          (img) {
            setState(() {
              showCompresingImgLoading = false; //to show prepare image loading
            });
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (c) => PerpareImageToEdit(
                  img: imageFile,
                  memoryImg: img,
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xfffa54da5),
                Color(0xff5b4cb0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        maxRadius: 60,
                        minRadius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          'assets/img/MainImg.png',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Story Editor',
                          style: GoogleFonts.lekton(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          await _bannerAd.dispose();

                          if (await PermitionModel().getCameraPermition() ==
                              true) {
                            pickImageFromCamera();
                          } else {
                            print('No Permitons');
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(5),
                              child: Icon(
                                FontAwesomeIcons.camera,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'الكاميرا',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (await PermitionModel().getGalaryPermition() ==
                              true) {
                            pickImageFromGalary();
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(5),
                              child: Icon(
                                FontAwesomeIcons.solidImage,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'صورك',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await _bannerAd.dispose();
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (c) => About(),
                            ),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(5),
                              child: Icon(
                                FontAwesomeIcons.infoCircle,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'حول التطبيق',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              showCompresingImgLoading
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: CupertinoAlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: CupertinoActivityIndicator(
                                radius: 20,
                              ),
                            ),
                            Text("جار تهئية الصورة")
                          ],
                        ),
                      ),
                    )
                  : Offstage(),
            ],
          ),
        ),
      ),
    );
  }

//////////////////// code of admob Ads
  InterstitialAd interstitialAd;
  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
    _bannerAd = AdmobService().myBanner
      ..load()
      ..show(anchorType: AnchorType.bottom);
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

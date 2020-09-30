import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storesharing/model/admobService.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool dev = true;

  Future<void> lunchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حول '),
        centerTitle: true,
      ),
      // floatingActionButton: IconButton(
      //     icon: Icon(Icons.cloud_circle),
      //     onPressed: () async {
      //       const url = 'https://instagram.com/hussein3li7';
      //       if (await canLaunch(url)) {
      //         await launch(url);
      //       } else {
      //         throw 'Could not launch $url';
      //       }
      //     }),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  //  color: Color(0xff393776),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/MainImg.png'),
                      ),
                    ),
                  ),
                  Text(
                    'معدل القصص',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: dev ? Color(0xff6c5ce7) : Color(0xff82589F),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton.icon(
                      color: Color(0xff6c5ce7),
                      textColor: Colors.white,
                      //textTheme: ButtonTextTheme.accent,
                      elevation: 0,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          dev = true;
                        });
                      },
                      icon: Icon(Icons.developer_mode),
                      label: Text('مطور التطبيق'),
                    ),
                    RaisedButton.icon(
                      color: Color(0xff82589F),
                      textColor: Colors.white,
                      //textTheme: ButtonTextTheme.accent,
                      elevation: 0,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          dev = false;
                        });
                      },
                      icon: Icon(Icons.info_outline),
                      label: Text('حول التطبيق  '),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                color: dev ? Color(0xff6c5ce7) : Color(0xff82589F),
                child: SingleChildScrollView(
                  scrollDirection: dev ? Axis.horizontal : Axis.vertical,
                  child: AnimatedCrossFade(
                    alignment: Alignment.center,
                    crossFadeState: dev
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 500),
                    firstChild: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            foregroundColor: Colors.black,
                            child: Text(
                              'Hussein Ali',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.white,
                            minRadius: 40.0,
                            maxRadius: 60.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '  للتواصل مع مطور التطبيق  ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.instagram,
                                        color: Color(0xff8e44ad),
                                        size: 25,
                                      ),
                                      onPressed: () async {
                                        if (await canLaunch(
                                            'https://instagram.com/hussein3li7')) {
                                          launch(
                                              'https://instagram.com/hussein3li7');
                                        } else {
                                          print('Could not launch ');
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.facebook,
                                        color: Color(0xff6c5ce7),
                                      ),
                                      onPressed: () async {
                                        // sendAndRetrieveMessage();
                                        if (await canLaunch(
                                            'https://facebook.com/hussein3li7')) {
                                          launch(
                                              'https://facebook.com/hussein3li7');
                                        } else {
                                          print('Could not launch ');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    secondChild: Container(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'تطبيق مناهجنا يوفر كافة المستلزمات الدراسية من ملازم و المراجعات المركزة  والاسئلة الوزارية للسنين السابقة والنتائج الوزارية للصفوف المنتهية مع امكانية الامتحان الاليكتروني للطالب اي انه الطالب يستطيع ان يختبر نفسهُ في كلاميات المواد الدراسية مع امكانية  تسجيل الدخول بالاستخدام الايميل والرمز السري ويتيح للمستخدم حفظ الاسئلة والمرشحات والملازم في الحساب ويتيح امكانية تنزيل الملفات من المراجعات المركزة والملازم  واسئلة والنتائج الوزارية على الهاتف وتتم اضافة البيانات  من ملازم واسئلة ومراجعات مركزة الى التطبيق بشكل يومي ',
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//////////////////// code of admob Ads
  ///

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
    super.dispose();
    _bannerAd.dispose();
    interstitialAd.dispose();
  }
}

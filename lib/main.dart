import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storesharing/GUi/imgEditor/imgEditorPro/imgEditorPro.dart';
import 'package:storesharing/provider/freeTextStyleProvider.dart';
import 'package:storesharing/provider/provider.dart';
import 'GUi/Home/HomeWidget.dart';
import 'GUi/firstSlider/slider.dart';
import 'model/admobService.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());

  FirebaseAdMob.instance.initialize(appId: AdmobService().getAppId());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showHomePage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderStatus();
  }

  getSliderStatus() async {
    await SharedPreferences.getInstance().then((status) async {
      if (status.getBool("SliderStatus") == true) {
        setState(() {
          showHomePage = true;
        });
      } else {
        setState(() {
          showHomePage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => FontProvider(),
        ),
        ChangeNotifierProvider(
          create: (c) => ImgProvider(),
        ),
        ChangeNotifierProvider(
          create: (c) => BackGroundImageColor(),
        ),
        ChangeNotifierProvider(create: (c) => FreeTextStyle()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: showHomePage ? HomeApp() : FirstSlider(),
        // home: ImageEditorProClass(),
        title: 'معدل القصص',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.black26,
            elevation: 0.0,
          ),
          fontFamily: GoogleFonts.cairo().fontFamily,
          brightness: Brightness.dark,
          textTheme: TextTheme(
            bodyText1: const TextStyle(color: Colors.red, fontSize: 50),
            caption: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

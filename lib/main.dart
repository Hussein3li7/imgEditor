import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storesharing/provider/provider.dart';
import 'GUi/Home/HomeWidget.dart';
import 'GUi/imgEditor/imgEditorPro/imgEditorPro.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         home: HomeApp(),
       // home: ImageEditorProClass(),
        title: 'Edite',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0.0,
          ),
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

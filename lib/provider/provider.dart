import 'dart:io';

import 'package:flutter/material.dart';

class FontProvider with ChangeNotifier {
  String fontFamily;
  double fontSize = 30;
  TextAlign textAlign = TextAlign.right;
  String textedite = "";
  changeFontStyle(String _fontFamily) {
    fontFamily = _fontFamily;

    notifyListeners();
  }

  changeFontSize(double _fontSize) {
    fontSize = _fontSize;
    notifyListeners();
  }

  chageFontTextAlign(TextAlign _textAlign) {
    textAlign = _textAlign;
    notifyListeners();
  }

  chageTextEdite(String text) {
    textedite = text;
    notifyListeners();
  }
}

class ImgProvider with ChangeNotifier {
  File img;
  File capturedImage;
  BoxFit imgBoxFit = BoxFit.fitWidth;

  chageBoxFItImage(BoxFit _boxFitImg) {
    imgBoxFit = _boxFitImg;
    notifyListeners();
  }

  perPareImageToShare(File _img) {
    img = _img;
    notifyListeners();
  }

  setCapturedImage(File img) {
    capturedImage = img;
    notifyListeners();
  }
}

class BackGroundImageColor with ChangeNotifier {
  Color topColor = Color(0xff6c5ce7);
  Color buttomColor = Color(0xff0984e3);
  String topColorStringForStory = "#6c5ce7";
  String buttonColorStringForStory = "#0984e3";
  Color fontColor = Colors.white;
  Color bgColor = Colors.white;
  chageTopBgColor(Color _topColor) {
    topColor = _topColor;
    notifyListeners();
  }

  chageButtomBgColor(Color _bottomColor) {
    buttomColor = _bottomColor;
    notifyListeners();
  }

  changeFontColor(Color color) {
    fontColor = color;
    notifyListeners();
  }

  changeBGColor(Color color) {
    bgColor = color;
    notifyListeners();
  }

  chageTopStringColor(String c) {
    topColorStringForStory = c;
    notifyListeners();
  }

  chageButtomStringColor(String c) {
    buttonColorStringForStory = c;
    notifyListeners();
  }
}

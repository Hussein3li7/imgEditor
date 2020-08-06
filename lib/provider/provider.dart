import 'dart:io';

import 'package:flutter/cupertino.dart';

class FontProvider with ChangeNotifier {
  String fontFamily;
  double fontSize = 30;
  TextAlign textAlign = TextAlign.right;
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
}

class ImgProvider with ChangeNotifier {
  File img;
  File capturedImage;
  BoxFit imgBoxFit = BoxFit.contain;

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

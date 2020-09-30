import 'package:flutter/material.dart'; 

class FreeTextStyle with ChangeNotifier {
  bool borderRadui = false, shadow = false;
  Color textBgColor = Colors.white;

  chageBorderRaduisStyle(bool borRadis) {
    borderRadui = borRadis;
    notifyListeners();
  }

  chageShadowStyle(bool _shadow) {
    shadow = _shadow;
    notifyListeners();
  }

  chageTextBgColor(Color color) {
    textBgColor = color;
    notifyListeners();
  }
}

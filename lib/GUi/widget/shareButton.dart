import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:social_share/social_share.dart';

class ShareButton extends StatefulWidget {
  File img;
  String topColor;
  String buttomColor;
  ShareButton({this.img, this.buttomColor, this.topColor});
  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  List<Widget> itemsToBodyComplete;

  GlobalKey<CircleFloatingButtonState> key03 =
      GlobalKey<CircleFloatingButtonState>();
  @override
  void initState() {
    itemsToBodyComplete = [
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          print(widget.topColor);
          print(widget.buttomColor);
          SocialShare.shareInstagramStory(
            widget.img.path,
            widget.topColor == null ? "#2d3436" : "#${widget.topColor}",
            widget.buttomColor == null ? "#2d3436" : "#${widget.buttomColor}",
            "https:/instagram.com/hussein3li7",
          );
        },
        child: Icon(FontAwesomeIcons.instagram),
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.indigoAccent,
        onPressed: () {
          key03.currentState.close();
        },
        child: Icon(FontAwesomeIcons.facebook),
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          key03.currentState.close();
        },
        child: Icon(FontAwesomeIcons.whatsapp),
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.indigoAccent,
        onPressed: () {
          key03.currentState.close();
        },
        child: Icon(FontAwesomeIcons.twitter),
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.indigoAccent,
        onPressed: () {
          key03.currentState.close();
        },
        child: Icon(FontAwesomeIcons.telegram),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircleFloatingButton.floatingActionButton(
      key: key03,
      items: itemsToBodyComplete,
      color: Colors.blue,
      icon: Icons.share,
      duration: Duration(milliseconds: 400),
      curveAnim: Curves.ease,
      useOpacity: true,
    );
  }
}

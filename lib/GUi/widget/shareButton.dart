import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:social_share/social_share.dart';
import 'package:storesharing/GUi/imgEditor/editedText/editeTextWidget.dart';
import 'package:storesharing/provider/provider.dart';

class ShareButton extends StatefulWidget {
  File img;
  ShareButton({this.img});
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
          SocialShare.shareInstagramStory(
            widget.img.path,
            "red",
            "blue",
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
    var imgProvider = Provider.of<ImgProvider>(context);

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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        onPressed: () async {
          SocialShare.shareFacebookStory(
            widget.img.path,
            "#ffffff",
            "#000000",
            "https://deep-link-url",
            appId: "174657503423764",
          );
        },
        child: Icon(FontAwesomeIcons.facebook),
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.blueAccent,
        onPressed: () async{
         SocialShare.shareWhatsapp('content');
        },
        child: Icon(FontAwesomeIcons.whatsapp),
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.indigoAccent,
        onPressed: () async {
          SocialShare.shareTwitter('captionText',
              hashtags: ['a,dd,bs'],
              trailingText: 'titler',
              url: 'twitter.com/hussein3li7');
        },
        child: Icon(FontAwesomeIcons.twitter),
      ),
      FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: Colors.indigoAccent,
        onPressed: () async {
          SocialShare.shareOptions('da',imagePath: widget.img.path);
        },
        child: Icon(FontAwesomeIcons.share),
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

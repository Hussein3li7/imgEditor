import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storesharing/GUi/widget/shareButton.dart';
import 'package:storesharing/provider/provider.dart';
import '../../model/colorList.dart';

class LiveViewImage extends StatefulWidget {
  File img;
  LiveViewImage({this.img});
  @override
  _LiveViewImageState createState() => _LiveViewImageState();
}

class _LiveViewImageState extends State<LiveViewImage> {
  @override
  Widget build(BuildContext context) {
    var bgImageColor = Provider.of<BackGroundImageColor>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bgImageColor.topColor,
                bgImageColor.buttomColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView.builder(
                    itemCount: allColors.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return GestureDetector(
                        onTap: () {
                          List c = allColors[i].toString().split("0xff");
                          List colorStr = c[c.length - 1].toString().split(")");
                          print(colorStr[0]);

                          bgImageColor.chageTopBgColor(
                            allColors[i],
                          );

                          bgImageColor.chageTopStringColor(
                            colorStr[0],
                          );
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            color: allColors[i],
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(widget.img),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView.builder(
                      itemCount: allColors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i) {
                        return GestureDetector(
                          onTap: () {
                            List c = allColors[i].toString().split("0xff");
                            List colorStr =
                                c[c.length - 1].toString().split(")");
                            print(colorStr[0]);
                            bgImageColor.chageButtomBgColor(
                              allColors[i],
                            );
                            bgImageColor.chageButtomStringColor(
                              colorStr[0],
                            );
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              color: allColors[i],
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ShareButton(
        img: widget.img,
        topColor: bgImageColor.topColorStringForStory,
        buttomColor: bgImageColor.buttonColorStringForStory,
      ),
    );
  }
}

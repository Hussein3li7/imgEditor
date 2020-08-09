import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:storesharing/GUi/widget/googleFontList.dart';
import 'package:storesharing/model/colorList.dart';
import 'package:storesharing/provider/provider.dart';
import 'package:wave_slider/wave_slider.dart';

import 'FreeTextView.dart';

class AddFreeTextToImage extends StatefulWidget {
  File img;
  AddFreeTextToImage({this.img});
  @override
  _AddFreeTextToImageState createState() => _AddFreeTextToImageState();
}

class _AddFreeTextToImageState extends State<AddFreeTextToImage> {
  List fontsize = [];
  var howmuchwidgetis = 0;
  List multiwidget = [];
  List<Offset> offsets = [];
  List<String> texts = [];
  List<Color> textColors = [];
  List<String> textFonts = [];
  String addTextToWidget = "";
  bool showAddTextToWidget = false;
  bool showColorList = false;
  double _fontSize = 25;
  Color fontColor = Colors.white;

  TextEditingController textCtrl = new TextEditingController();

  ScreenshotController screenshotController = new ScreenshotController();

  Widget textFeilds(BuildContext c) {
    var fontColor = Provider.of<BackGroundImageColor>(context);
    var fontStyle = Provider.of<FontProvider>(context);
    TextEditingController textCtrl2 =
        new TextEditingController(text: fontStyle.textedite);

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(.6),
      child: TextField(
        autofocus: true,
        controller: fontStyle.textedite.isEmpty ? textCtrl : textCtrl2,
        onChanged: (s) {
          fontStyle.textedite = s; //return edtied text(Update text)
        },
        style: TextStyle(
          color: fontColor.fontColor,
          fontFamily: fontStyle.fontFamily,
          fontSize: _fontSize,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget waveSlider() {
    return Positioned(
      child: Transform.rotate(
        angle: 23.55,
        origin: Offset(-140, 55),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(.5),
          ),
          width: 150,
          height: 50,
          child: WaveSlider(
            displayTrackball: true,
            color: Colors.white,
            onChanged: (double dragUpdate) {
              if (dragUpdate * 50 < 13) {
                return;
              } else {
                setState(() {
                  _fontSize = dragUpdate * 50;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  void applyChageToImage() async {
    print('sac');
    await screenshotController.capture().then((img) {
      Navigator.pop(context, img);
    });
  }

  @override
  Widget build(BuildContext context) {
    var fontStyle = Provider.of<FontProvider>(context);
    var fontColor = Provider.of<BackGroundImageColor>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back), onPressed: applyChageToImage),
        actions: showAddTextToWidget
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      if (fontStyle.textedite.isEmpty)
                        multiwidget.add(
                          textCtrl.text.trim().toString(),
                        ); // if not edted Text
                      else
                        multiwidget.add(
                          fontStyle.textedite.trim(),
                        ); //user edite text and save it

                      offsets.add(Offset(50, 50));
                      textColors.add(fontColor.fontColor);
                      textFonts.add(fontStyle.fontFamily);
                      fontsize.add(_fontSize);
                      howmuchwidgetis++;
                      showAddTextToWidget = !showAddTextToWidget;
                      textCtrl.clear();
                    });
                    fontStyle.textedite = "";
                  },
                ),
              ]
            : <Widget>[
                IconButton(
                    icon: Icon(Icons.text_fields),
                    onPressed: () async {
                      setState(() {
                        showAddTextToWidget = !showAddTextToWidget;
                      });
                    }),
              ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(widget.img),
                  ),
                ),
                Stack(
                  children: multiwidget.asMap().entries.map((f) {
                    return FreeTextView(
                      left: offsets[f.key].dx,
                      top: offsets[f.key].dy,
                      ontap: () {
                        fontStyle.chageTextEdite(multiwidget[f.key]);
                        multiwidget.removeAt(f.key);
                        textColors.removeAt(f.key);
                        textFonts.removeAt(f.key);
                        fontsize.removeAt(f.key);
                        setState(() {
                          showAddTextToWidget = true;
                        });
                      },
                      onpanupdate: (details) {
                        setState(() {
                          offsets[f.key] = Offset(
                            offsets[f.key].dx + details.delta.dx,
                            offsets[f.key].dy + details.delta.dy,
                          );
                        });
                      },
                      value: f.value != null
                          ? f.value.toString()
                          : "", // equal "" to dont return null value
                      fontsize: fontsize[f.key].toDouble(),
                      align: TextAlign.center,
                      fontFamily: textFonts[f.key],
                      color: textColors[f.key],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          showAddTextToWidget ? textFeilds(context) : Offstage(),
          showAddTextToWidget
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GoogleFontList(),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        color: Colors.black.withOpacity(.4),
                        alignment: Alignment.bottomRight,
                        child: ListView.builder(
                          itemCount: allColors.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (c, i) {
                            return GestureDetector(
                              onTap: () {
                                fontColor.changeFontColor(allColors[i]);
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
                    )
                  ],
                )
              : Offstage(),
          showAddTextToWidget ? waveSlider() : Offstage(),
        ],
      ),
    );
  }
}

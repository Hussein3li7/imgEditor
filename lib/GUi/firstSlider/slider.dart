import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storesharing/GUi/Home/HomeWidget.dart';
import 'package:storesharing/GUi/firstSlider/sliders/slied4Paint.dart';
import 'package:storesharing/GUi/firstSlider/sliders/slied5LivePreview.dart';

import 'sliders/slied1Filter.dart';
import 'sliders/slied2ImageTItle.dart';
import 'sliders/slied3FreeText.dart';

class FirstSlider extends StatefulWidget {
  @override
  _FirstSliderState createState() => _FirstSliderState();
}

class _FirstSliderState extends State<FirstSlider> {
  PageController controller;

  bool slider = true;
  int index = 0;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView(
                controller: controller,
                onPageChanged: (int i) {
                  setState(() {
                    index = i;
                  });
                },
                children: <Widget>[
                  Slide1(),
                  Slide2(),
                  Slide3(),
                  Slide4(),
                  Slide5(),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            width: index == 0 ? 20 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: index == 0 ? Colors.grey : Colors.black,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print(index);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            width: index == 1 ? 20 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: index == 1 ? Colors.grey : Colors.black,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            width: index == 2 ? 20 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: index == 2 ? Colors.grey : Colors.black,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            width: index == 3 ? 20 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: index == 3 ? Colors.grey : Colors.black,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            width: index == 4 ? 20 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: index == 4 ? Colors.grey : Colors.black,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.white,
                      focusColor: Colors.white,
                      textColor: Colors.black,
                      disabledTextColor: Colors.white,
                      highlightColor: Colors.white,
                      hoverColor: Colors.white,
                      splashColor: Colors.white,
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      disabledElevation: 0,
                      disabledColor: Colors.white,
                      onPressed: () async {
                        await SharedPreferences.getInstance().then((state) {
                          state.setBool("SliderStatus", true).then((_) {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (c) => HomeApp(),
                              ),
                            );
                          });
                        });
                      },
                      child: Text(
                        "تخطي",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

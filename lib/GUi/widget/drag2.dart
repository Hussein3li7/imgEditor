import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class Drag2 extends StatefulWidget {
  Drag2({Key key}) : super(key: key);
  @override
  _Drag2State createState() => _Drag2State();
}

class _Drag2State extends State<Drag2> {
  double top = 0;
  double left = 0;
  ScreenshotController _screenshotController = new ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Screenshot(
          controller: _screenshotController,
          child: Container(
            child: Stack(
              overflow: Overflow.clip,
              fit: StackFit.passthrough,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/img/MainImg.png'),
                ),
                Draggable(
                  child: Container(
                    padding: EdgeInsets.only(top: top, left: left),
                    child: DragItem(),
                  ),
                  feedback: Container(
                    padding: EdgeInsets.only(top: top, left: left),
                    child: DragItem(),
                  ),
                  childWhenDragging: Container(
                    padding: EdgeInsets.only(top: top, left: left),
                    child: DragItem(),
                  ),
                  onDragCompleted: () {},
                  onDragEnd: (drag) {
                    setState(() {
                      top = top + drag.offset.dy < 0 ? 0 : top + drag.offset.dy;
                      left =
                          left + drag.offset.dx < 0 ? 0 : left + drag.offset.dx;
                    });
                  },
                ),
                // RaisedButton(onPressed: () async {
                //   await _screenshotController.capture(pixelRatio: 2.9).then((image) async {
                //     SocialShare.shareInstagramStory(
                //       image.path,
                //       "blue",
                //       "blue",
                //       "https://deep-link-url",
                //     ).then((data) {
                //       print(data);
                //     });
                //   });
                // }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.camera,
      color: Colors.red,
    );
  }
}

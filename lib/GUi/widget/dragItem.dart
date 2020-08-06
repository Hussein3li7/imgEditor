import 'package:flutter/material.dart';

class Drag extends StatefulWidget {
  Drag({Key key}) : super(key: key);
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  double top = 0;
  double left = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(30),
        height: 300,
        width: 300,
        color: Colors.indigo.shade100,
        child: Draggable(
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
              if ((top + drag.offset.dy) > (300.0 - 30.0)) {
                top = (300.0 - 30.0);
              } else if ((top + drag.offset.dy - 30.0) < 0.0) {
                top = 0;
              } else {
                top = top + drag.offset.dy - 30.0;
              }
              if ((left + drag.offset.dx) > (300.0 - 30.0)) {
                left = (300.0 - 30.0);
              } else if ((left + drag.offset.dx - 30.0) < 0.0) {
                left = 0;
              } else {
                left = left + drag.offset.dx - 30.0;
              }
            });
          },
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(57748, fontFamily: 'MaterialIcons'),
      size: 30,
    );
  }
}

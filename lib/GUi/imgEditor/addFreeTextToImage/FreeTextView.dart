import 'package:flutter/material.dart';

class FreeTextView extends StatefulWidget {
  final double left;
  final double top;
  final Function ontap;
  final Function(DragUpdateDetails) onpanupdate;
  final double fontsize;
  final String value;
  final TextAlign align;
  final String fontFamily;
  final Color color;
  const FreeTextView({
    Key key,
    this.left,
    this.top,
    this.ontap,
    this.onpanupdate,
    this.fontsize,
    this.value,
    this.align,
    this.fontFamily,
    this.color,
  }) : super(key: key);
  @override
  _FreeTextViewState createState() => _FreeTextViewState();
}

class _FreeTextViewState extends State<FreeTextView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: widget.ontap,
        onPanUpdate: widget.onpanupdate,
        child: Text(
          widget.value,
          textAlign: widget.align,
          style: TextStyle(
              fontSize: widget.fontsize,
              fontFamily: widget.fontFamily,
              color: widget.color),
        ),
      ),
    );
  }
}

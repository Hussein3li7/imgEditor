import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storesharing/provider/freeTextStyleProvider.dart';

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
  final Color bgColor;
  final bool raduis;
  final bool showBgColor;

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
    this.raduis,
    this.bgColor,
    this.showBgColor,
  }) : super(key: key);
  @override
  _FreeTextViewState createState() => _FreeTextViewState();
}

class _FreeTextViewState extends State<FreeTextView> {
  @override
  Widget build(BuildContext context) {
    var textProviderStyle = Provider.of<FreeTextStyle>(context);
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: widget.ontap,
        onPanUpdate: widget.onpanupdate,
        child: Container(
          //  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
            color: widget.showBgColor ? widget.bgColor : Colors.transparent,
            borderRadius: widget.raduis
                ? BorderRadius.circular(100)
                : BorderRadius.circular(0),
          ),
          child: Text(
            widget.value,
            textAlign: widget.align,
            style: TextStyle(
              fontSize: widget.fontsize,
              fontFamily: widget.fontFamily,
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}

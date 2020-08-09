import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storesharing/provider/provider.dart';

class GoogleFontList extends StatefulWidget {
  @override
  _GoogleFontListState createState() => _GoogleFontListState();
}

class _GoogleFontListState extends State<GoogleFontList> {
  @override
  Widget build(BuildContext context) {
    var setFontStyle = Provider.of<FontProvider>(context);
    List<TextStyle> googleENglishFont = [
      GoogleFonts.lato(),
      GoogleFonts.cairo(),
      GoogleFonts.caladea(),
    ];
    List<TextStyle> googleArabicFont = [
      GoogleFonts.cairo(
        color: Colors.white,
      ),
      GoogleFonts.amiri(
        color: Colors.white,
      ),
      GoogleFonts.tajawal(
        color: Colors.white,
      ),
      GoogleFonts.almarai(
        color: Colors.white,
      ),
      GoogleFonts.changa(
        color: Colors.white,
      ),
      GoogleFonts.elMessiri(
        color: Colors.white,
      ),
      GoogleFonts.lemonada(
        color: Colors.white,
      ),
      GoogleFonts.markaziText(
        color: Colors.white,
      ),
      GoogleFonts.lalezar(
        color: Colors.white,
      ),
      GoogleFonts.reemKufi(
        color: Colors.white,
      ),
      GoogleFonts.mada(
        color: Colors.white,
      ),
      GoogleFonts.scheherazade(
        color: Colors.white,
      ),
      GoogleFonts.lateef(
        color: Colors.white,
      ),
      GoogleFonts.mirza(
        color: Colors.white,
      ),
      GoogleFonts.rakkas(
        color: Colors.white,
      ),
      GoogleFonts.katibeh(
        color: Colors.white,
      ),
      GoogleFonts.arefRuqaa(
        color: Colors.white,
      ),
      GoogleFonts.vibes(
        color: Colors.white,
      ),
      GoogleFonts.jomhuria(
        color: Colors.white,
      ),
    ];
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: googleArabicFont.map((e) {
            return GestureDetector(
              onTap: () {
                setFontStyle.changeFontStyle(e.fontFamily);
              },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'خط',
                  style: e,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

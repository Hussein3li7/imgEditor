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
        color: Colors.black,
      ),
      GoogleFonts.amiri(
        color: Colors.black,
      ),
      GoogleFonts.tajawal(
        color: Colors.black,
      ),
      GoogleFonts.almarai(
        color: Colors.black,
      ),
      GoogleFonts.changa(
        color: Colors.black,
      ),
      GoogleFonts.elMessiri(
        color: Colors.black,
      ),
      GoogleFonts.lemonada(
        color: Colors.black,
      ),
      GoogleFonts.markaziText(
        color: Colors.black,
      ),
      GoogleFonts.lalezar(
        color: Colors.black,
      ),
      GoogleFonts.reemKufi(
        color: Colors.black,
      ),
      GoogleFonts.mada(
        color: Colors.black,
      ),
      GoogleFonts.scheherazade(
        color: Colors.black,
      ),
      GoogleFonts.lateef(
        color: Colors.black,
      ),
      GoogleFonts.mirza(
        color: Colors.black,
      ),
      GoogleFonts.rakkas(
        color: Colors.black,
      ),
      GoogleFonts.katibeh(
        color: Colors.black,
      ),
      GoogleFonts.arefRuqaa(
        color: Colors.black,
      ),
      GoogleFonts.vibes(
        color: Colors.black,
      ),
      GoogleFonts.jomhuria(
        color: Colors.black,
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
                alignment: Alignment.center,
                width: 50,
                height: 50,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'اسم',
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

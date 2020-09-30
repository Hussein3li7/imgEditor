import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Slide5 extends StatefulWidget {
  @override
  _Slide5State createState() => _Slide5State();
}

class _Slide5State extends State<Slide5> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderStatus();
  }

  getSliderStatus() async {
    await SharedPreferences.getInstance().then((status) async {
      if (status.getBool("SliderStatus") != true) {
        await status.setBool("SliderStatus", true).then((_) {
          print("Done set Slider Status to true");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              width: size.width,
              child: Image.asset(
                "assets/img/sliderImages/liveStory.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              width: size.width,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "تحضير القصة",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "يمكنك التعديل على خلفيات الصورة قبل تصديرها لقصة فيسبوك او انستغرام ",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

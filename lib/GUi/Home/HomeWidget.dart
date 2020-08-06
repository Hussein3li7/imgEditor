import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/photofilters.dart';
import 'package:storesharing/GUi/imgEditor/AddFilterToImage.dart';
import 'package:storesharing/GUi/imgEditor/editor2.dart';
import 'package:storesharing/GUi/imgEditor/PerpareImageToEdit.dart';
import 'package:storesharing/model/permetionsModel.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as imageLib;

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;
  pickImageFromGalary() async {
    try {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (c) => PerpareImageToEdit(img: imageFile),
          ),
        );

        // fileName = p.basename(imageFile.path);
        // var image = imageLib.decodeImage(imageFile.readAsBytesSync());
        // image = imageLib.copyResize(image, width: 600);
        // await Navigator.push(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => new PhotoSelectorToTryFilter(
        //       title: Text("Photo Filter Example"),
        //       image: image,
        //       filters: presetFiltersList,
        //       filename: fileName,
        //       loader: Center(child: CircularProgressIndicator()),
        //       fit: BoxFit.contain,
        //     ),
        //   ),
        // );
      }

      // await ImagePicker.platform.pickImage(source: ImageSource.gallery).then(
      //   (imgFIle) {
      //     if (imgFIle.path != null) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (c) => Editor2(
      //             imageFile: File.fromRawPath(imgFIle.path),
      //           ),
      //         ),
      //       );
      //     } else {
      //       print('Error');
      //     }
      //   },
      // );
    } catch (e) {
      print(e.toString());
    }
  }

  pickImageFromCamera() async {
    try {
      var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (imageFile != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => PerpareImageToEdit(
              img: imageFile,
            ),
          ),
        );
      } else {
        print('Error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xfffa54da5),
                Color(0xff5b4cb0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 80,
                    minRadius: 50,
                    backgroundImage: AssetImage(
                      'assets/img/MainImg.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Hussein App',
                      style: TextTheme().caption,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      if (await PermitionModel().getCameraPermition() == true) {
                        pickImageFromCamera();
                      } else {
                        print('No Permitons');
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.all(5),
                          child: Icon(
                            FontAwesomeIcons.camera,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (await PermitionModel().getGalaryPermition() == true) {
                        pickImageFromGalary();
                      } else {}
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.all(5),
                          child: Icon(
                            FontAwesomeIcons.solidImage,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        Text('Galary'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(
                      //     builder: (c) => PerpareImageToEdit(
                      //       img: 'fwf',
                      //     ),
                      //   ),
                      // );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.all(5),
                          child: Icon(
                            FontAwesomeIcons.redoAlt,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        Text('Try It'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

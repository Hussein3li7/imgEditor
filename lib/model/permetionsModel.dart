import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermitionModel {
  Future<bool> getGalaryPermition() async {
    if (await Permission.photos.request().isDenied) {
      Permission.photos.request().then((per) {
        if (per.isGranted) {
          return true;
        } else {
          return false;
        }
      });
    } else {
      return true;
    }
  }

  Future<bool> getCameraPermition() async {
    if (await Permission.camera.request().isDenied) {
      Permission.camera.request().then((per) {
        if (per.isGranted) {
          return true;
        } else {
          return false;
        }
      });
    } else {
      return true;
    }
  }
}

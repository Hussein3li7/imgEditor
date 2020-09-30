import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdmobService {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['book', 'students', 'school', 'university'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[
      'C181E43851906E56D084FC3F72ADAF8B'
    ], // Android emulators are considered test devices
  );

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: getBannerAdUnitId(),
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.failedToLoad) {
        print('error');
      }
      // print("BannerAd event is $event");
    },
  );

  InterstitialAd myInterstitial = InterstitialAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: getInterstitialAdUnitId(),
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      //  print("InterstitialAd event is $event");
    },
  );

  String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-4463119466252038~4657827244';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-4463119466252038~5279917736';
    }
    return null;
  }

  static String getBannerAdUnitId() {
    // banner Ads Id
    if (Platform.isIOS) {
      return 'ca-app-pub-4463119466252038/1648520520';
    } else if (Platform.isAndroid) {
      return BannerAd.testAdUnitId;
      //  return 'ca-app-pub-4463119466252038/7723098303';
    }
    return null;
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-4463119466252038/6187844416';
    } else if (Platform.isAndroid) {
      return InterstitialAd.testAdUnitId;
      // return 'ca-app-pub-4463119466252038/3209138227';
    }
    return null;
  }
}

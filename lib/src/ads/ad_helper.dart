import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsHelper {
  static final GoogleAdsHelper _soundHelper = GoogleAdsHelper._internal();
  factory GoogleAdsHelper() {
    return _soundHelper;
  }

  GoogleAdsHelper._internal();

  static BannerAd? bannerAd;
  static InterstitialAd? interstitialAd;

  static bool isPaidMember = true;

  static Future<void> initialize() async {
    // await MobileAds.instance.initialize();
    //isPaidMember = false;
  }

  String get bannerAdUnitId {
    String bannerAdUinitID = '';
    if (Platform.isAndroid) {
      bannerAdUinitID = FlutterConfig.get('BANNER_ANDROID_AD_UNIT_ID');
    } else if (Platform.isIOS) {
      bannerAdUinitID = FlutterConfig.get('BANNER_IOS_AD_UNIT_ID');
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
    // print('Ads unit ID $bannerAdUinitID');
    return bannerAdUinitID;
  }

  String get interstitialAdUnitId {
    String interstitialAdUnitId = '';
    if (Platform.isAndroid) {
      interstitialAdUnitId = FlutterConfig.get('INTERSTITIAL_ANDROID_AD_UNIT_ID');
    } else if (Platform.isIOS) {
      interstitialAdUnitId = FlutterConfig.get('INTERSTITIAL_IOS_AD_UNIT_ID');
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
    // print('Ads unit ID $interstitialAdUnitId');
    return interstitialAdUnitId;
  }

  static void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: GoogleAdsHelper().bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('LocalPrint $ad loaded: ${ad.responseInfo?.mediationAdapterClassName}');
        },
        onAdFailedToLoad: (ad, err) {
          print('LocalPrint Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );

    bannerAd!.load();
  }

  static Future<void> loadInterstitialAd() {
    return InterstitialAd.load(
      adUnitId: GoogleAdsHelper().interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // loadInterstitialAd();
              return;
            },
          );
          // _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          // _isInterstitialAdReady = false;
        },
      ),
    );
  }

  static Future<String> showInterstitialAd() async {
    if (isPaidMember) {
      return '';
    }
    if (interstitialAd != null) {
      await interstitialAd!.show();
      return '';
    }

    return '';
  }

  static void dispose() {
    print('Disposal of Adds occuring');
    bannerAd?.dispose();
    interstitialAd?.dispose();
  }

  Widget placeBannerAd() {
    //If paid member then show noting
    // return AppUtils.emptyWidget();

    return SizedBox(
      height: 50,
      child: AdWidget(ad: bannerAd!),
    );
  }

  Widget placeAlignedBannerAd() {
    return isPaidMember
        ? SizedBox.shrink()
        : Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: bannerAd!.size.width.toDouble(),
              height: bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            ),
          );
  }
}

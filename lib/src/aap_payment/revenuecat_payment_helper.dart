import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:mathgame/src/core/app_utils.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as purchases;

class RevenueCatPaymentHelper {
  static final String REVENUE_CAT_ANDROID_KEY = "goog_fsHpOhPQpRllqMFZmChkWvkFxrL";
  static final String REVENUE_CAT_IOS_KEY = "appl_SZfHSfyofDXREYggvXUBjkudHaI";

  static final RevenueCatPaymentHelper _soundHelper = RevenueCatPaymentHelper._internal();
  factory RevenueCatPaymentHelper() {
    return _soundHelper;
  }

  RevenueCatPaymentHelper._internal();

  Future<void> initPlatformState() async {
    await purchases.Purchases.setLogLevel(purchases.LogLevel.debug);

    purchases.PurchasesConfiguration configuration = purchases.PurchasesConfiguration(REVENUE_CAT_IOS_KEY);

    if (Platform.isAndroid) {
      configuration = purchases.PurchasesConfiguration(REVENUE_CAT_IOS_KEY);
    } else if (Platform.isIOS) {
      configuration = purchases.PurchasesConfiguration(REVENUE_CAT_IOS_KEY);
    }
    await purchases.Purchases.configure(configuration);
  }

  getPurchaseOfferings() async {
    try {
      purchases.Offerings offerings = await purchases.Purchases.getOfferings();
      if (offerings.current != null) {
        print(offerings.current);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}

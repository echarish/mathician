import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as revenueCat;

const REVENUE_CAT_ANDROID_KEY = "goog_fsHpOhPQpRllqMFZmChkWvkFxrL";
const String REVENUE_CAT_IOS_KEY = "appl_SZfHSfyofDXREYggvXUBjkudHaI";

const ENTITLEMENT_ID_IOS = "mathiciannoadssub";
const ENTITELMENT_ID_ANDROID = "mathiciannoadssubandroid";

class RevenueCatPaymentHelper {
  late revenueCat.Package packageToPurchase;

  static final RevenueCatPaymentHelper _soundHelper = RevenueCatPaymentHelper._internal();
  factory RevenueCatPaymentHelper() {
    return _soundHelper;
  }

  RevenueCatPaymentHelper._internal();

  init() async {
    await initPlatformState();
    // await getPurchaseCuurentOfferings();
  }

  Future<void> initPlatformState() async {
    await revenueCat.Purchases.setLogLevel(revenueCat.LogLevel.debug);

    revenueCat.PurchasesConfiguration configuration = revenueCat.PurchasesConfiguration(REVENUE_CAT_IOS_KEY);

    if (Platform.isAndroid) {
      configuration = revenueCat.PurchasesConfiguration(REVENUE_CAT_IOS_KEY);
    } else if (Platform.isIOS) {
      configuration = revenueCat.PurchasesConfiguration(REVENUE_CAT_IOS_KEY);
    }
    await revenueCat.Purchases.configure(configuration);
  }

  Future<revenueCat.Offering?> getPurchaseCuurentOfferings() async {
    try {
      revenueCat.Offerings offerings = await revenueCat.Purchases.getOfferings();
      if (offerings.current != null) {
        print(offerings.current);
        offerings.current!.availablePackages.forEach((availablePackage) {
          packageToPurchase = availablePackage;
        });

        return offerings.current!;
      }
    } on PlatformException catch (e) {
      print(e);
    }
    return null;
  }

  makePurchase() async {
    try {
      revenueCat.CustomerInfo customerInfo = await revenueCat.Purchases.purchasePackage(packageToPurchase);
      var isPro = customerInfo.entitlements.all[_getEntitlementId()]!.isActive;
      if (isPro) {
        // Unlock that great "pro" content
      }
    } on PlatformException catch (e) {
      var errorCode = revenueCat.PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != revenueCat.PurchasesErrorCode.purchaseCancelledError) {
        print(e);
      }
    }
  }

  String _getEntitlementId() {
    if (Platform.isIOS) {
      return ENTITLEMENT_ID_IOS;
    } else {
      return ENTITELMENT_ID_ANDROID;
    }
  }

  Future<bool> isPadiMember() async {
    try {
      revenueCat.CustomerInfo customerInfo = await revenueCat.Purchases.getCustomerInfo();
      if (customerInfo.entitlements.all[_getEntitlementId()] != null && customerInfo.entitlements.all[_getEntitlementId()]!.isActive) {
        return true;
      }
    } on PlatformException catch (e) {
      print(e);
    }
    return false;
  }

  getCustomerInfo() async {
    return revenueCat.Purchases.getCustomerInfo();
  }
}

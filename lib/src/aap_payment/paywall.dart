import 'package:flutter/material.dart';
import 'package:mathgame/src/aap_payment/styles.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

const footerText = "For terms and condition";
const footerTnClink = "https://rightcode.app/termscondition";

class Paywall extends StatefulWidget {
  final Offering offering;

  const Paywall({Key? key, required this.offering}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isbright = theme.brightness == Brightness.light;

    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration:
                  BoxDecoration(color: isbright ? Colors.black : Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
              child: Center(
                child: Text(
                  '✨ Mathician No Ads - Premium ✨ ',
                  style: theme.textTheme.headline6!.copyWith(color: isbright ? Colors.white : Colors.black),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  'Click here to get Ads free access',
                  style: theme.textTheme.subtitle2!.copyWith(color: isbright ? Colors.white : Colors.black),
                ),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.blue,
                      width: 5.0,
                    ),
                  ),
                  surfaceTintColor: Colors.blue,
                  elevation: 15,
                  color: isbright ? Colors.white : Colors.black,
                  child: ListTile(
                    onTap: () async {
                      try {
                        CustomerInfo customerInfo = await Purchases.purchasePackage(myProductList[index]);
                        print(customerInfo);
                      } catch (e) {
                        print(e);
                      }

                      setState(() {});
                      Navigator.pop(context);
                    },
                    title: Text(
                      myProductList[index].storeProduct.title,
                      style: theme.textTheme.headline6!.copyWith(color: isbright ? Colors.black : Colors.white, fontSize: kFontSizeNormal),
                    ),
                    subtitle: Text(
                      myProductList[index].storeProduct.description,
                      style: theme.textTheme.headline6!.copyWith(color: isbright ? Colors.black : Colors.white, fontSize: kFontSizeSuperSmall),
                    ),
                    trailing: Text(
                      myProductList[index].storeProduct.priceString,
                      style: theme.textTheme.headline6!.copyWith(color: isbright ? Colors.black : Colors.white, fontSize: kFontSizeMedium),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      footerText,
                      style: theme.textTheme.headline6!.copyWith(color: isbright ? Colors.white : Colors.black, fontSize: kFontSizeMedium),
                    ),
                    GestureDetector(
                      child: Text(
                        footerTnClink,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        launchUrlString(footerTnClink);
                      },
                    )
                  ],
                ),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

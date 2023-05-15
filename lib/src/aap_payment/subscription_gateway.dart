import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathgame/src/aap_payment/paywall.dart';
import 'package:mathgame/src/aap_payment/revenuecat_payment_helper.dart';
import 'package:mathgame/src/aap_payment/styles.dart';
import 'package:mathgame/src/core/app_utils.dart';
import 'package:mathgame/src/core/view_utils.dart';

class SubscriptionGateway extends StatefulWidget {
  const SubscriptionGateway({super.key});

  @override
  State<SubscriptionGateway> createState() => _SubscriptionGatewayState();
}

class _SubscriptionGatewayState extends State<SubscriptionGateway> {
  String userAnswer = '';
  int firstNumber = AppUtils.twoDigitRandomNumber();
  int secondNumber = AppUtils.twoDigitRandomNumber();
  int sumOfTwoNumber = 0;
  bool _validateError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sumOfTwoNumber = firstNumber + secondNumber;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Buy Subscription',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: ViewUtils().getViewSize(28), fontWeight: FontWeight.bold),
          ),
          // toolbarHeight: 0,
          // elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Theme.of(context).primaryColor,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: _gatewayBody(),
          ),
        ),
      ),
    );
  }

  _gatewayBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Before we proceed for subscripiton purchase',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _challengeBlock(),
        _challengeAnswerActionButton(),
      ],
    );
  }

  _challengeAnswerActionButton() {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(ViewUtils.CANCEL_CLICKED);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          child: Text('Buy Subscription'),
          onPressed: () async {
            print(userAnswer);
            if (userAnswer.isEmpty) {
              setState(() {
                _validateError = true;
              });
            } else if (userAnswer.isNotEmpty) {
              bool isNumeric = num.tryParse(userAnswer) != null;
              if (!isNumeric) {
                setState(() {
                  _validateError = true;
                });
              } else if (num.tryParse(userAnswer) != sumOfTwoNumber) {
                setState(() {
                  _validateError = true;
                });
              } else {
                //We open subscripton logic here
                dynamic offering = await RevenueCatPaymentHelper().getPurchaseCuurentOfferings();

                await showModalBottomSheet(
                  useRootNavigator: true,
                  isDismissible: true,
                  isScrollControlled: true,
                  backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
                      return Paywall(
                        offering: offering,
                      );
                    });
                  },
                );
              }
            } else {
              _validateError = false;
              Navigator.of(context).pop(ViewUtils.OK_CLICKED);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: AppUtils.getContrastColor(theme.colorScheme.secondary),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _challengeBlock() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Whats the sum of below two number?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$firstNumber + $secondNumber',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 3,
          onChanged: (text) {
            userAnswer = text;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Answer',
            errorText: _validateError ? 'Please input your answer.' : null,
          ),
        ),
      )
    ]);
  }
}

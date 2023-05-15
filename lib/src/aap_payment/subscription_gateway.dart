import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buy Subscription'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _gatewayBody(),
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
          onPressed: () {
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
                print('Ready to buy now');
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

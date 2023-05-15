import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_utils.dart';

class ViewUtils {
  static const String OK_CLICKED = "OkClicked";
  static const String CANCEL_CLICKED = "CancelClicked";

  static showAlert(BuildContext context, String title, String message, String okButtonTitle) {
    ThemeData theme = Theme.of(context);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          icon: Icon(
            Icons.update,
            size: 40,
          ),
          iconColor: theme.primaryColor,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(message),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(CANCEL_CLICKED);
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
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop(OK_CLICKED);
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
      },
    );
  }

  static proveYouAreAdult(BuildContext context, Function setState) async {
    ThemeData theme = Theme.of(context);
    String userAnswer = '';
    int firstNumber = AppUtils.twoDigitRandomNumber();
    int secondNumber = AppUtils.twoDigitRandomNumber();
    int sumOfTwoNumber = firstNumber + secondNumber;

    bool _validateError = false;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          icon: Icon(
            Icons.update,
            size: 40,
          ),
          iconColor: theme.primaryColor,
          title: Text(
            'Before we proceed for subscripiton purchase',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Whats the sum of two number?',
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
                maxLength: 15,
                onChanged: (text) {
                  userAnswer = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your Answer',
                  errorText: _validateError ? 'Please input bowler name.' : null,
                ),
              ),
            )
          ]),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(CANCEL_CLICKED);
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
                if (userAnswer.isEmpty) {
                  setState(() {
                    _validateError = true;
                  });
                }
                if (userAnswer.isNotEmpty) {
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
                  Navigator.of(context).pop(OK_CLICKED);
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
      },
    );
  }
}

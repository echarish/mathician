import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_utils.dart';
import 'dart:ui' as ui;

class ViewUtils {
  ViewUtils._internal();
  static final ViewUtils _viewUtils = ViewUtils._internal();
  factory ViewUtils() {
    _viewUtils._setPhoneOrTablet();
    return _viewUtils;
  }

  static const String OK_CLICKED = "OkClicked";
  static const String CANCEL_CLICKED = "CancelClicked";

  late bool isTablet;
  late bool isPhone;

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

  getViewSize(double textSize) {
    if (isTablet) {
      return textSize + 20;
    }
    return textSize;
  }

  getMoveTopForTab(double textSize) {
    if (isTablet) {
      return textSize - 40;
    }
    return textSize;
  }

  getMoveLeftForTab(double textSize) {
    if (isTablet) {
      return textSize - 20;
    }
    return textSize;
  }

  getMoveRightForTab(double textSize) {
    if (isTablet) {
      return textSize - 20;
    }
    return textSize;
  }

  _setPhoneOrTablet() {
    final double devicePixelRatio = ui.window.devicePixelRatio;
    final ui.Size size = ui.window.physicalSize;
    final double width = size.width;
    final double height = size.height;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }
  }
}

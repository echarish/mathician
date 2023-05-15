import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathgame/src/ads/ad_helper.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/app_utils.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/core/view_utils.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/common/common_alert_dialog.dart';
import 'package:mathgame/src/ui/common/common_difficulty_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_button_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetLeftEnter;
  late Animation<Offset> _offsetRightEnter;
  late bool isHomePageOpen;

  @override
  void initState() {
    super.initState();
    isHomePageOpen = false;
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetLeftEnter = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);

    _offsetRightEnter = Tween<Offset>(
      begin: Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();

    GoogleAdsHelper.loadBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // bool _validateError = false;
  // proveYouAreAdult() {
  //   ThemeData theme = Theme.of(context);
  //   String userAnswer = '';
  //   int firstNumber = AppUtils.twoDigitRandomNumber();
  //   int secondNumber = AppUtils.twoDigitRandomNumber();
  //   int sumOfTwoNumber = firstNumber + secondNumber;

  //   return showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         icon: Icon(
  //           Icons.update,
  //           size: 40,
  //         ),
  //         iconColor: theme.primaryColor,
  //         title: Text(
  //           'Before we proceed for subscripiton purchase',
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         content: SizedBox(
  //           height: 200,
  //           child: Column(children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 'Whats the sum of two number?',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 '$firstNumber + $secondNumber',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
  //               child: TextField(
  //                 keyboardType: TextInputType.number,
  //                 maxLength: 3,
  //                 onChanged: (text) {
  //                   userAnswer = text;
  //                 },
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   hintText: 'Your Answer',
  //                   errorText: _validateError ? 'Please input your answer.' : null,
  //                 ),
  //               ),
  //             )
  //           ]),
  //         ),
  //         actionsAlignment: MainAxisAlignment.center,
  //         actions: [
  //           ElevatedButton(
  //             child: Text("Cancel"),
  //             onPressed: () {
  //               Navigator.of(context).pop(ViewUtils.CANCEL_CLICKED);
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.red,
  //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //               textStyle: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           ElevatedButton(
  //             child: Text('Buy Subscription'),
  //             onPressed: () {
  //               print(userAnswer);
  //               if (userAnswer.isEmpty) {
  //                 setState(() {
  //                   _validateError = true;
  //                 });
  //               } else if (userAnswer.isNotEmpty) {
  //                 bool isNumeric = num.tryParse(userAnswer) != null;
  //                 if (!isNumeric) {
  //                   setState(() {
  //                     _validateError = true;
  //                   });
  //                 } else if (num.tryParse(userAnswer) != sumOfTwoNumber) {
  //                   setState(() {
  //                     _validateError = true;
  //                   });
  //                 } else {
  //                   //We open subscripton logic here
  //                   print('Ready to buy now');
  //                 }
  //               } else {
  //                 _validateError = false;
  //                 Navigator.of(context).pop(ViewUtils.OK_CLICKED);
  //               }
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: theme.colorScheme.secondary,
  //               foregroundColor: AppUtils.getContrastColor(theme.colorScheme.secondary),
  //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //               textStyle: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.infoDialogBgColor, borderRadius: BorderRadius.circular(18)),
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.icTrophy,
                                width: ViewUtils().getViewSize(24),
                                height: ViewUtils().getViewSize(24),
                              ),
                              SizedBox(width: 5),
                              Consumer<DashboardProvider>(
                                builder: (context, model, child) => Text(model.overallScore.toString(),
                                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: ViewUtils().getViewSize(20))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        String getRidOfAds = await ViewUtils.showAlert(
                          context,
                          'Get Rid of Ads',
                          'With a small monthly subscribtion you can get rid of Ads. Are you ready to get rid of ads and enjoy the puzzles and memory excersie without inneruption.',
                          'Yes! Remove Ads',
                        );
                        if (getRidOfAds == ViewUtils.OK_CLICKED) {
                          Navigator.pushNamed(
                            context,
                            KeyUtil.gatewayQuestion,
                            // ModalRoute.withName(KeyUtil.gatewayQuestion),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.light ? AppAssets.adsBlockDark : AppAssets.adsBlockLight,
                          width: ViewUtils().getViewSize(24),
                          height: ViewUtils().getViewSize(24),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog<bool>(
                          context: context,
                          builder: (newContext) {
                            final model = Provider.of<ThemeProvider>(context, listen: true);
                            return CommonAlertDialog(
                              child: ChangeNotifierProvider.value(
                                value: model,
                                child: CommonDifficultyView(
                                  selectedDifficulty: model.difficultyType,
                                ),
                              ),
                            );
                          },
                          barrierDismissible: false,
                        ).then((value) {});
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.light ? AppAssets.ic3dStairsDark : AppAssets.ic3dStairsLight,
                          width: ViewUtils().getViewSize(24),
                          height: ViewUtils().getViewSize(24),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<ThemeProvider>().changeTheme();
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.light ? AppAssets.icDarkMode : AppAssets.icLightMode,
                          width: ViewUtils().getViewSize(24),
                          height: ViewUtils().getViewSize(24),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                GoogleAdsHelper().placeAlignedBannerAd(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 36),
                        Text(
                          "MATHician",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: ViewUtils().getViewSize(28), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Train Your Brain, Improve Your Math Skill",
                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: ViewUtils().getViewSize(14)),
                        ),
                        SizedBox(height: 36),
                        DashboardButtonView(
                          dashboard: KeyUtil.dashboardItems[0],
                          position: _offsetLeftEnter,
                          onTab: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              KeyUtil.home,
                              ModalRoute.withName(KeyUtil.dashboard),
                              arguments: Tuple2(KeyUtil.dashboardItems[0], MediaQuery.of(context).padding.top),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        DashboardButtonView(
                          dashboard: KeyUtil.dashboardItems[1],
                          position: _offsetRightEnter,
                          onTab: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              KeyUtil.home,
                              ModalRoute.withName(KeyUtil.dashboard),
                              arguments: Tuple2(KeyUtil.dashboardItems[1], MediaQuery.of(context).padding.top),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        DashboardButtonView(
                          dashboard: KeyUtil.dashboardItems[2],
                          position: _offsetLeftEnter,
                          onTab: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              KeyUtil.home,
                              ModalRoute.withName(KeyUtil.dashboard),
                              arguments: Tuple2(KeyUtil.dashboardItems[2], MediaQuery.of(context).padding.top),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.infoDialogBgColor, borderRadius: BorderRadius.circular(18)),
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text("MathIcian by RightCode", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal,fontSize: ViewUtils().getViewSize(14) )),
                      ),
                      SizedBox(width: 12),
                      FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) =>
                            Text("v${snapshot.data?.version}", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: ViewUtils().getViewSize(14) )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/core/view_utils.dart';
import 'package:mathgame/src/ui/common/common_tab_animation_view.dart';
import 'package:tuple/tuple.dart';

class HomeButtonView extends StatelessWidget {
  final Function onTab;
  final String title;
  final String icon;
  final int score;
  final Tuple2<Color, Color> colorTuple;
  final double opacity;

  const HomeButtonView({
    Key? key,
    required this.title,
    required this.icon,
    required this.score,
    required this.colorTuple,
    required this.onTab,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTabAnimationView(
      onTab: onTab,
      isDelayed: true,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: ViewUtils().getViewSize(24), vertical: ViewUtils().getViewSize(10)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
              alignment: Alignment.center,
              height: ViewUtils().getViewSize(132),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorTuple.item1, colorTuple.item2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Transform(
                      transform: Matrix4.identity().scaled(5.2)..translate(-17.0, -27.0),
                      child: SvgPicture.asset(
                        icon,
                        color: Colors.white.withOpacity(opacity),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ViewUtils().getViewSize(24)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                icon,
                                width: ViewUtils().getViewSize(28),
                                height: ViewUtils().getViewSize(28),
                              ),
                              SizedBox(width: ViewUtils().getViewSize(22)),
                              Text(title,
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: ViewUtils().getViewSize(18), color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(
                            color: Theme.of(context).colorScheme.dividerColor,
                            height: 1,
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Score:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(fontSize: ViewUtils().getViewSize(14), color: Colors.white)),
                                    SizedBox(width: ViewUtils().getViewSize(14)),
                                    SvgPicture.asset(
                                      AppAssets.icTrophy,
                                      width: ViewUtils().getViewSize(18),
                                      height: ViewUtils().getViewSize(18),
                                    ),
                                    SizedBox(width: 4),
                                    Text(score.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(fontSize: ViewUtils().getViewSize(14), color: Colors.white)),
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                AppAssets.icPlayCircleFilled,
                                color: Colors.white,
                                height: ViewUtils().getViewSize(39),
                                width: ViewUtils().getViewSize(39),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform(
                      transform: Matrix4.identity()..translate(0.0, 2),
                      child: SvgPicture.asset(AppAssets.icButtonShape),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

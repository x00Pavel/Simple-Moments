import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/ui/nav_screens/home/home_cubit.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';
import 'package:simple_moments/utils/global_strings.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:simple_moments/utils/text_styles.dart';

final pagePosition = ValueNotifier(0);

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: deviceWidth,
          padding: EdgeInsets.only(
              top: spacingPadding5,
              left: spacingPadding6,
              right: spacingPadding6,
              bottom: spacingPadding2),
          decoration: const BoxDecoration(color: kBottomNav),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavItem(itemName: moments, index: 0, icon: homeIcon),
              globalGap(10),
              BottomNavItem(itemName: profile, index: 1, icon: profileIcon),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: spacingPadding9,
          child: GestureDetector(
            onTap: () => context.read<HomeCubit>().captureMoment(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.all(spacingPadding4),
                    decoration: BoxDecoration(
                        color: kPrimaryBlue,
                        borderRadius: BorderRadius.circular(100)),
                    child: SvgPicture.asset(camera)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BottomNavItem extends StatefulWidget {
  final String icon;
  final String itemName;
  final int index;

  const BottomNavItem(
      {Key? key,
      required this.icon,
      required this.itemName,
      required this.index})
      : super(key: key);

  @override
  State<BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pagePosition,
        builder: (context, int value, child) {
          return GestureDetector(
            onTap: () => pagePosition.value = widget.index,
            child: Container(
              height: spacingPadding12,
              color: Colors.transparent,
              child: Column(
                children: [
                  SvgPicture.asset(widget.icon,
                      color: widget.index != value ? null : Colors.white,
                      height: 4.5.heightAdjusted),
                  globalGap(1.5),
                  Text(
                    widget.itemName,
                    style: regularText(
                        fontSize: 12,
                        color: widget.index == value
                            ? Colors.white
                            : Colors.white.withAlpha(100)),
                  )
                ],
              ),
            ),
          );
        });
  }
}

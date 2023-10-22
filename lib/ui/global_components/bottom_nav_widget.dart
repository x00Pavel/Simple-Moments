import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Container(
      padding: EdgeInsets.only(
          top: spacingPadding3,
          left: spacingPadding6,
          right: spacingPadding6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 13,
              blurRadius: 7,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomNavItem(itemName: home, index: 0, icon: homeIcon),
          globalGap(10),
          BottomNavItem(itemName: profile, index: 1, icon: profileIcon),
        ],
      ),
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
                            : Colors.black54.withAlpha(100)),
                  )
                ],
              ),
            ),
          );
        });
  }
}

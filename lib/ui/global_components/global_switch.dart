import 'package:flutter/material.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/size_config.dart';

class GlobalSwitch extends StatelessWidget {
  const GlobalSwitch({super.key, required this.isOpened, this.onTap});

  final bool isOpened;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: spacingPadding10,
        alignment: isOpened ? Alignment.centerRight : Alignment.centerLeft,
        padding: EdgeInsets.only(
          top: .8.heightAdjusted,
          bottom: .8.heightAdjusted,
          right: spacingPadding1,
          left: spacingPadding1,
        ),
        decoration: BoxDecoration(
            color: isOpened ? kPrimaryBlue : kTextColor.withAlpha(100),
            borderRadius: BorderRadius.circular(spacingPadding20)),
        child: isOpened
            ? Container(
                height: spacingPadding4,
                width: spacingPadding4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: kTextColor.withAlpha(50),
                        offset: const Offset(3, 0),
                        spreadRadius: 2,
                        blurRadius: 2)
                  ],
                ),
              )
            : Container(
                height: spacingPadding4,
                width: spacingPadding4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: kTextColor.withAlpha(50),
                          offset: const Offset(3, 0),
                          spreadRadius: 2,
                          blurRadius: 2)
                    ]),
              ),
      ),
    );
  }
}

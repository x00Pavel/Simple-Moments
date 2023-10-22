import 'package:flutter/material.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:simple_moments/utils/text_styles.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton(
      {Key? key,
      this.btnText,
      this.height,
      this.width,
      this.padding,
      this.fillColor,
      this.outlineColor,
      this.child,
      this.onTap})
      : super(key: key);

  final String? btnText;
  final Color? fillColor;
  final Color? outlineColor;
  final Widget? child;
  final double? height, width;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: padding ?? EdgeInsets.symmetric(vertical: 3.3.heightAdjusted),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fillColor ?? kPrimaryBlue,
          border: Border.all(
              color: outlineColor != null
                  ? outlineColor!.withAlpha(100)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(spacingPadding8),
        ),
        child: child ??
            Text(
              btnText ?? '',
              style:
                  semiBoldText(fontSize: 16, color: outlineColor ?? Colors.white),
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/text_styles.dart';

class ValidatorWidget extends StatelessWidget {
  const ValidatorWidget({
    super.key,
    required this.validatorText,
    required this.isValidated,
  });

  final String validatorText;
  final bool isValidated;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: spacingPadding2, vertical: spacingPadding1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isValidated
                ? kPrimaryBlue.withAlpha(20)
                : kTextColor.withAlpha(20)),
        child: Text(validatorText,
            style: regularText(
                color: isValidated ? kPrimaryBlue : kTextColor, fontSize: 11)),
      ),
    );
  }
}

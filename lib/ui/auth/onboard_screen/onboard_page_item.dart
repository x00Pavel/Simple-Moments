
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';

class OnboardPageItem extends StatefulWidget {
  const OnboardPageItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.bodyText,
  }) : super(key: key);

  final String imagePath, title, bodyText;

  @override
  State<OnboardPageItem> createState() => _OnboardPageItemState();
}

class _OnboardPageItemState extends State<OnboardPageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeIn(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,
          child: SvgPicture.asset(widget.imagePath, fit: BoxFit.cover),
        ),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: spacingPadding4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              globalGap(20),
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeIn,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: boldText(
                      fontSize: 24, color: Colors.white),
                ),
              ),
              globalGap(3),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: spacingPadding8),
          child: FadeIn(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            child: Text(
              widget.bodyText,
              textAlign: TextAlign.center,
              style: regularText(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

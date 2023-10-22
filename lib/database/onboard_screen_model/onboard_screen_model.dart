
import 'package:flutter/material.dart';
import 'package:simple_moments/ui/auth/onboard_screen/onboard_page_item.dart';
import 'package:simple_moments/utils/global_assets.dart';

class OnboardScreenModel {
  String imagePath, title, bodyText;

  OnboardScreenModel({
    required this.imagePath,
    required this.title,
    required this.bodyText,
  });

  static List<OnboardScreenModel> onboardScreens = [
    OnboardScreenModel(
        imagePath: capture,
        title: 'Capture moments you love.',
        bodyText:
            'You never have to deal with partially filled moments again.'),
    OnboardScreenModel(
        imagePath: merge,
        title: 'Captured moments are merged into one.',
        bodyText:
            'Each moment is preserved and merged with other ones.'),
    OnboardScreenModel(
        imagePath: view,
        title: 'View captured moments anytime.',
        bodyText:
            'Your moments are saved and can be viewed anytime you want.'),
  ];

  static List<Widget> listOfOnboardPagesWidgets() {
    List<Widget> listOfOnboardPages = [
      OnboardPageItem(
          imagePath: onboardScreens[0].imagePath,
          title: onboardScreens[0].title,
          bodyText: onboardScreens[0].bodyText),
      OnboardPageItem(
          imagePath: onboardScreens[1].imagePath,
          title: onboardScreens[1].title,
          bodyText: onboardScreens[1].bodyText),
      OnboardPageItem(
          imagePath: onboardScreens[2].imagePath,
          title: onboardScreens[2].title,
          bodyText: onboardScreens[2].bodyText),
    ];
    return listOfOnboardPages;
  }
}

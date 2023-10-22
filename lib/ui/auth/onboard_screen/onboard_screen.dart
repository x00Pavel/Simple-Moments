import 'package:flutter/material.dart';
import 'package:simple_moments/database/onboard_screen_model/onboard_screen_model.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/text_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int pageCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryDark,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) => setState(() => pageCount = value),
                children: OnboardScreenModel.listOfOnboardPagesWidgets(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: spacingPadding8, vertical: spacingPadding10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: Colors.white,
                      activeDotColor: kPrimaryBlue,
                    ),
                  ),
                  pageCount == 2
                      ? GestureDetector(
                          onTap: () =>
                              globalNavigateUntil(route: Routes.getStartedScreen),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: spacingPadding4,
                                vertical: spacingPadding2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text('Continue',
                                style: semiBoldText(
                                    color: kPrimaryDark, fontSize: 16)),
                          ),
                        )
                      : Text('Skip',
                          style:
                              semiBoldText(color: Colors.white, fontSize: 16))
                ],
              ),
            )
          ],
        ));
  }
}

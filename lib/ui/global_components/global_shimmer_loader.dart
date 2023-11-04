import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';

class MomentsShimmerLoader extends StatelessWidget {
  const MomentsShimmerLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: spacingPadding4),
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: spacingPadding2),
              child: Stack(
                children: [
                  FadeShimmer(
                    height: spacingPadding25,
                    width: deviceWidth,
                    radius: 10,
                    highlightColor: Colors.white.withAlpha(30),
                    baseColor: const Color(0xff484848).withAlpha(100),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(playButton,
                              height: spacingPadding8, width: spacingPadding8),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

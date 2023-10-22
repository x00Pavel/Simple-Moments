
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';

import 'global_assets.dart';

void showLoaderDialog() {
  showGeneralDialog(
      context: buildContext,
      barrierColor: Colors.black.withAlpha(180),
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => WillPopScope(
          onWillPop: () async => false,
          child: const Center(child: AnimatedLogo(size: 20))));
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({
    super.key,
    this.animate = true,
    this.size,
  });

  final bool animate;
  final double? size;

  @override
  State<StatefulWidget> createState() => _EdenAnimatedLogo();
}

class _EdenAnimatedLogo extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInEdenAnimatedLogoOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _fadeInEdenAnimatedLogoOut =
        Tween<double>(begin: 0.0, end: 0.8).animate(animation);

    if (widget.animate) {
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animation.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animation.forward();
        }
      });
    }
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
          opacity: _fadeInEdenAnimatedLogoOut,
          child: Center(
            child: SvgPicture.asset(siplmet),
          )),
    );
  }
}

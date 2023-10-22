import 'package:flutter/material.dart';

import 'dimensions.dart';

class GlobalPadding extends StatelessWidget {
  const GlobalPadding(
      {required this.child,
      this.top = 0,
      this.horizontal = 0,
      Key? key})
      : super(key: key);

  final Widget child;
  final double horizontal, top;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: horizontal == 0 ? spacingPadding4 : horizontal,
            right: horizontal == 0 ? spacingPadding4 : horizontal,
            top: top == 0 ? spacingPadding15 : top),
        child: child);
  }
}

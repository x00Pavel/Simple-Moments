import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/text_styles.dart';

class MomentsCounter extends StatelessWidget {
  final int start;
  const MomentsCounter({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            width: spacingPadding15,
            padding: EdgeInsets.symmetric(
                vertical: spacingPadding2, horizontal: spacingPadding2),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: AnimatedFlipCounter(
              value: start, // decimal precision
              textStyle: mediumText(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

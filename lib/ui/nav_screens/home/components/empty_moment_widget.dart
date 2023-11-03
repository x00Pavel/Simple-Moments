import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';
import 'package:simple_moments/utils/global_strings.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';

class EmptyMomentWidget extends StatelessWidget {
  const EmptyMomentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: deviceWidth,
        margin: EdgeInsets.only(bottom: spacingPadding22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(empty, color: Colors.white.withAlpha(50)),
            globalGap(6),
            Text(noMoments,
                style: mediumText(
                    color: Colors.white.withAlpha(195), fontSize: 18)),
            globalGap(1),
            Text(hitTheCamera,
                textAlign: TextAlign.center,
                style: regularText(
                    color: Colors.white.withAlpha(160), fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';

class MomentsBackButton extends StatelessWidget {
  const MomentsBackButton({super.key, required this.stopRecording});

  final Function() stopRecording;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 30,
      child: GestureDetector(
        onTap: () {
          globalPop();
          stopRecording;
        },
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: spacingPadding2,
              vertical: spacingPadding2,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: kPrimaryDark)),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/ui/nav_screens/camera_moments/moments_cubit.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';

class MomentsControls extends StatelessWidget {
  const MomentsControls(
      {super.key, required this.startRecording, required this.switchCamera});

  final Function() startRecording, switchCamera;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: startRecording,
            child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spacingPadding4,
                  vertical: spacingPadding3,
                ),
                decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                child: SvgPicture.asset(stop, height: spacingPadding7)),
          ),
          GestureDetector(
            onTap: switchCamera,
            child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spacingPadding4,
                  vertical: spacingPadding4,
                ),
                decoration: const BoxDecoration(
                    color: kPrimaryBlue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: SvgPicture.asset(alternateCam)),
          ),
        ],
      ),
    );
  }
}

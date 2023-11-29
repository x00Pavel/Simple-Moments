import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/ui/nav_screens/camera_moments/moments_cubit.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';

class MomentsControls extends StatelessWidget {
  const MomentsControls(
      {super.key,
      required this.isRecording,
      required this.startRecording,
      required this.switchCamera});

  final Function() startRecording, switchCamera;
  final bool isRecording;

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
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight:
                          isRecording ? const Radius.circular(20) : Radius.zero,
                      bottomRight:
                          isRecording ? const Radius.circular(20) : Radius.zero,
                      bottomLeft: const Radius.circular(20),
                    )),
                child: SvgPicture.asset(stop,
                    color: isRecording ? null : Colors.white,
                    height: spacingPadding7)),
          ),
          if (!isRecording)
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

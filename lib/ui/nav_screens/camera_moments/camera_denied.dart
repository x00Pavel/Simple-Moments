import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/global_components/global_button.dart';
import 'package:simple_moments/ui/nav_screens/home/home_cubit.dart';
import 'package:simple_moments/ui/nav_screens/profile/profile_cubit.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';
import 'package:simple_moments/utils/global_padding.dart';
import 'package:simple_moments/utils/global_strings.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';

class CameraDenied extends StatelessWidget {
  const CameraDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return GlobalPadding(
            horizontal: spacingPadding6,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(cameraNoAccess, height: spacingPadding13),
                globalGap(10),
                Text(accessDenied,
                    textAlign: TextAlign.center,
                    style: semiBoldText(color: Colors.white, fontSize: 22)),
                globalGap(3),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacingPadding6),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'You can always change your mind and grant '
                            'us access from your ',
                        style: regularText(color: Colors.grey, fontSize: 15),
                        children: [
                          TextSpan(
                              text: 'settings,',
                              style:
                                  regularText(color: kPrimaryBlue, fontSize: 15)
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context
                                    .read<HomeCubit>()
                                    .enableCameraFromSettings()),
                        ]),
                  ),
                ),
                globalGap(spacingPadding3),
                GlobalButton(
                  btnText: 'Go Back',
                  onTap: () => globalPop(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

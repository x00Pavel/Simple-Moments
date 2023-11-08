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

class AllowCamera extends StatelessWidget {
  const AllowCamera({super.key});

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
                SvgPicture.asset(cameraAccess),
                globalGap(10),
                Text(giveAccess,
                    style: semiBoldText(color: Colors.white, fontSize: 22)),
                globalGap(3),
                Text(inOrder,
                    textAlign: TextAlign.center,
                    style: regularText(
                        color: Colors.white.withAlpha(100), fontSize: 15)),
                globalGap(spacingPadding5),
                GlobalButton(
                  btnText: allowCameraMic,
                  onTap: () =>
                      context.read<HomeCubit>().allowCameraPermission(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

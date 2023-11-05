import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/auth/auth_cubit.dart';
import 'package:simple_moments/ui/global_components/global_button.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';
import 'package:simple_moments/utils/global_strings.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Stack(
        children: [
          Positioned.fill(child: Image.asset(background, fit: BoxFit.cover)),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: spacingPadding4, vertical: spacingPadding15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalGap(10),
                      Text(
                        'We’re Glad \nto Have you!',
                        style: boldText(color: kWhite, fontSize: 32),
                      ),
                      globalGap(5),
                      Text(
                        'Sign in to start creating wonderful moments.',
                        style: regularText(
                            color: kWhite.withAlpha(150), fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GlobalButton(
                          fillColor: kWhite,
                          onTap: () => context.read<AuthCubit>().googleAuth(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(google),
                              globalGap(2),
                              Text(
                                continueWithGoogle,
                                style: mediumText(
                                    color: kPrimaryDark, fontSize: 16),
                              )
                            ],
                          )),
                      globalGap(10),
                      GlobalButton(
                        btnText: continueWithPhone,
                        onTap: () =>
                            globalNavigateTo(route: Routes.signInScreen),
                      ),
                      globalGap(16),
                      Text(
                        privacy,
                        textAlign: TextAlign.center,
                        style: regularText(
                            color: kWhite.withAlpha(100), fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

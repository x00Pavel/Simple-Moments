import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/ui/global_components/confirm_dailog.dart';
import 'package:simple_moments/ui/global_components/global_switch.dart';
import 'package:simple_moments/ui/nav_screens/profile/profile_cubit.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/extensions/global_extensions.dart';
import 'package:simple_moments/utils/global_padding.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:simple_moments/utils/text_styles.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return GlobalPadding(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              globalGap(spacingPadding2),
              Text(
                  state.profileModel != null
                      ? state.profileModel!.user.name
                      : '',
                  style: semiBoldText(color: Colors.white, fontSize: 22)),
              Text(
                  state.profileModel != null
                      ? state.profileModel!.user.email
                      : '',
                  style: regularText(
                      color: Colors.white.withAlpha(100), fontSize: 16)),
              globalGap(spacingPadding4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Customize',
                    style: regularText(
                        color: Colors.white.withAlpha(100), fontSize: 16)),
              ),
              _ProfileContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notify moments',
                        style: regularText(color: Colors.white, fontSize: 16)),
                    GlobalSwitch(
                      isOpened: state.isOpened,
                      onTap: () => context.read<ProfileCubit>().isNotify(),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => context.read<ProfileCubit>().changeTime(),
                child: _ProfileContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notification time',
                          style:
                              regularText(color: Colors.white, fontSize: 16)),
                      Text(
                          state.profileModel != null
                              ? state.profileModel!.user.notifyTime.formatTime
                              : '',
                          style: regularText(
                              color: Colors.white.withAlpha(100),
                              fontSize: 16)),
                    ],
                  ),
                ),
              ),
              globalGap(spacingPadding2),
              _ProfileContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Wanna stop capturing?',
                        style: regularText(
                            color: Colors.white.withAlpha(100), fontSize: 16)),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => ConfirmDialog(
                              titleText: 'Do you really want to log out?',
                              warningText: 'Hope you loved our service?',
                              okText: 'Log out',
                              onTap: () =>
                                  context.read<ProfileCubit>().logOut())),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: spacingPadding3,
                            vertical: 1.5.heightAdjusted),
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(100),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text('Sign out',
                            style: semiBoldText(
                                color: kPrimaryDark, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _ProfileContainer extends StatelessWidget {
  const _ProfileContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: spacingPadding4),
      padding: EdgeInsets.symmetric(
          horizontal: spacingPadding4, vertical: spacingPadding4),
      decoration: BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

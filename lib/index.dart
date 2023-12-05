import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api_service/app_config/app_config.dart';
import 'dependency/get_it.dart';
import 'dependency/navigation/global_router.dart';
import 'dependency/navigation/global_routes.dart';
import 'dependency/navigation/navigation_service.dart';
import 'ui/auth/auth_cubit.dart';
import 'ui/nav_screens/camera_moments/moments_cubit.dart';
import 'ui/nav_screens/home/home_cubit.dart';
import 'ui/nav_screens/profile/profile_cubit.dart';
import 'utils/colors.dart';
import 'utils/size_config.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final AuthCubit _authCubit = getItInstance<AuthCubit>();
  final HomeCubit _homeCubit = getItInstance<HomeCubit>();
  final MomentCubit _momentCubit = getItInstance<MomentCubit>();
  final ProfileCubit _profileCubit = getItInstance<ProfileCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _authCubit.close();
    _homeCubit.close();
    _momentCubit.close();
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _authCubit),
                BlocProvider.value(value: _homeCubit),
                BlocProvider.value(value: _momentCubit),
                BlocProvider.value(value: _profileCubit),
              ],
              child: MaterialApp(
                  title: getItInstance<AppConfig>().appName,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(primarySwatch: materialPrimaryColor()),
                  initialRoute: Routes.splashScreen,
                  navigatorKey:
                      getItInstance<NavigationServiceImpl>().navigationKey,
                  onGenerateRoute: (value) =>
                      GlobalRouter.generateRoutes(value)));
        });
      }),
    );
  }
}

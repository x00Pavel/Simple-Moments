import 'package:simple_moments/ui/auth/get_started_screen/get_started_screen.dart';
import 'package:simple_moments/ui/auth/onboard_screen/onboard_screen.dart';
import 'package:simple_moments/ui/auth/otp_screen/otp_screen.dart';
import 'package:simple_moments/ui/auth/sign_in_screen/sign_in_screen.dart';
import 'package:simple_moments/ui/auth/splash_screen.dart';
import 'package:simple_moments/ui/domain/domain.dart';
import 'package:simple_moments/ui/nav_screens/camera_moments/allow_camera.dart';
import 'package:simple_moments/ui/nav_screens/camera_moments/camera_denied.dart';
import 'package:simple_moments/ui/nav_screens/camera_moments/camera_moments.dart';

import 'global_router_exports.dart';

class GlobalRouter {
  GlobalRouter._();

  static generateRoutes(settings) {
    switch (settings.name) {
      case Routes.domain:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const Domain());

      case Routes.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

      case Routes.onBoardScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnboardScreen());

      case Routes.signInScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignInScreen());

      case Routes.otpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OtpScreen());

      case Routes.getStartedScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const GetStartedScreen());

      case Routes.cameraMoments:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CameraMoments());

      case Routes.allowCamera:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllowCamera());

      case Routes.cameraDenied:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CameraDenied());
    }
  }
}

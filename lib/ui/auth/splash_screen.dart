import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/get_it.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/global_assets.dart';
import 'package:simple_moments/utils/helpers.dart';

import 'auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void afterSplash() async {
    await Future.delayed(
        const Duration(milliseconds: 1200), () async => checkStatus());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterSplash());
    getItInstance<AuthCubit>().getUserCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: Center(
        child: SvgPicture.asset(siplmet),
      ),
    );
  }
}

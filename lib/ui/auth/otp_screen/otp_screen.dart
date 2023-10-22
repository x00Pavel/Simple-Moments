import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/auth/auth_cubit.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var myDuration = ValueNotifier(const Duration(seconds: 60));
  final _focus = FocusNode();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isFocused = false;

  void _onFocusChange() => setState(() => isFocused = !isFocused);

  void setCountDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (myDuration.value.inSeconds == 0) {
        timer.cancel();
      } else {
        myDuration.value = Duration(seconds: myDuration.value.inSeconds - 1);
      }
    });
  }

  void resendOtpData() {
    myDuration.value = const Duration(seconds: 60);
    otpController.clear();
    setCountDown();
    context.read<AuthCubit>().resendOtp();
  }

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    setCountDown();
    super.initState();
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  final defaultPinTheme = pinTheme();

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: kPrimaryBlue),
      borderRadius: BorderRadius.circular(8),
    );

    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        return ValueListenableBuilder(
            valueListenable: myDuration,
            builder: (buildContext, Duration duration, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: kPrimaryDark,
                body: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: spacingPadding4, vertical: spacingPadding15),
                  child: Form(
                    key: formKey,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            globalGap(5),
                            GestureDetector(
                              onTap: () => globalPop(),
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: spacingPadding2),
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_back_ios,
                                        color: kWhite),
                                    Text('Verification',
                                        style: extraBoldText(
                                            fontSize: 30, color: kWhite)),
                                  ],
                                ),
                              ),
                            ),
                            globalGap(2),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'Enter the OTP sent to ',
                                  style: regularText(color: kWhite.withAlpha(150)),
                                  children: [
                                    TextSpan(
                                        text: state.phoneNumber,
                                        style: mediumText(color: kWhite)),
                                  ]),
                            ),
                            globalGap(20),
                            Pinput(
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: focusedPinTheme,
                              controller: otpController,
                              validator: (value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    value.length < 6) {
                                  return value.length < 6
                                      ? 'Pin is incorrect'
                                      : null;
                                }
                                return null;
                              },
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              onCompleted: (pin) {
                                if (formKey.validate) {
                                  context
                                      .read<AuthCubit>()
                                      .validateOtp(otp: otpController.text);
                                  otpController.clear();
                                }
                              },
                            ),
                            globalGap(5),
                            duration.inSeconds == 0
                                ? Center(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(
                                          spacingPadding1),
                                      onTap: () => resendOtpData(),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Text('Resend OTP',
                                            style: regularText(
                                                color: kWhite,
                                                fontSize: 14)),
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Resend OTP  in ',
                                          style: regularText(
                                              color:
                                                  kWhite.withAlpha(150),
                                              fontSize: 14)),
                                      Text(
                                          '${duration.inMinutes.toString()}:${duration.inSeconds.toString()}',
                                          style: mediumText(
                                              color: kWhite.withAlpha(150),
                                              fontSize: 14)),
                                    ],
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}

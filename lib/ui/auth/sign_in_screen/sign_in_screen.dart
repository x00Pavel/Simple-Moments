import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/auth/auth_cubit.dart';
import 'package:simple_moments/ui/global_components/global_button.dart';
import 'package:simple_moments/ui/global_components/phone_login.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_padding.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    context.read<AuthCubit>().resetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryDark,
        body: GlobalPadding(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    globalGap(5),
                    GestureDetector(
                      onTap: () => globalPop(),
                      child: Container(
                        color: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(vertical: spacingPadding2),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios, color: kWhite),
                            Text('Enter Phone Number',
                                style:
                                    extraBoldText(fontSize: 30, color: kWhite)),
                          ],
                        ),
                      ),
                    ),
                    globalGap(2),
                    Text('Just a moment to start creating moments.',
                        style: regularText(
                            color: kWhite.withAlpha(140), fontSize: 16)),
                    globalGap(25),
                    PhoneLogin(
                        phoneController: phoneController,
                        phoneNumberCallback: (value) => setState(() {
                              // phoneNumberCallback = value;
                              // context
                              //     .read<NexOfKinCubit>()
                              //     .nexOfKinDetail(phnNumber: value);
                            })),
                    globalGap(20),
                    GlobalButton(
                        btnText: 'Continue',
                        onTap: () {
                          if (_formKey.validate) {
                            print(phoneController.text);
                            context.read<AuthCubit>().authenticate(
                                phoneNumber:
                                    phoneController.text.replaceAll(' ', ''));
                          }
                        })
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: spacingPadding10),
                  child: GestureDetector(
                    // onTap: () =>
                    //     globalNavigateTo(route: Routes.termsAndConditions),
                    child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'By continuing you agree to the ',
                              style: regularText(color: kWhite.withAlpha(130)),
                              children: [
                                TextSpan(
                                    text: 'Privacy Terms & Conditions',
                                    style: regularText(color: kPrimaryBlue)
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline)),
                                TextSpan(
                                    text: ' without reservation.',
                                    style: regularText(
                                        color: kWhite.withAlpha(130)))
                              ]),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

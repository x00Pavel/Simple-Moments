import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:simple_moments/utils/text_styles.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({
    super.key,
    required this.phoneController,
    required this.phoneNumberCallback,
    this.initialValue,
  });

  final TextEditingController phoneController;
  final Function(String) phoneNumberCallback;
  final PhoneNumber? initialValue;

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  late PhoneNumber number = PhoneNumber(isoCode: 'CZ');

  final _focus = FocusNode();

  bool isFocused = false;

  void _onFocusChange() => setState(() => isFocused = !isFocused);

  late String dailCode;
  bool isValidated = true;

  @override
  void initState() {
    if (widget.initialValue != null) number = widget.initialValue!;
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number', style: regularText(color: kWhite)),
        globalGap(1.5),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: spacingPadding3, vertical: .5.heightAdjusted),
          decoration: BoxDecoration(
            color: kWhite.withAlpha(150),
              border: Border.all(
                  color: isFocused
                      ? kPrimaryBlue.withAlpha(150)
                      : kWhite.withAlpha(40)),
              borderRadius: BorderRadius.circular(10)),
          child: InternationalPhoneNumberInput(
            initialValue: number,
            hintText: 'Phone Number',
            maxLength: 13,
            focusNode: _focus,
            textFieldController: widget.phoneController,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            textStyle: regularText(fontSize: 14),
            inputBorder: InputBorder.none,
            enabledCountrySelection: true,
            selectorConfig: const SelectorConfig(
                showFlags: true,
                setSelectorButtonAsPrefixIcon: true,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
            onInputChanged: (PhoneNumber value) {
              dailCode = value.dialCode!;
            },
          ),
        ),
      ],
    );
  }
}

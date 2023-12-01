import 'package:flutter/material.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:simple_moments/utils/text_styles.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog(
      {Key? key,
      required this.titleText,
      required this.warningText,
      required this.okText,
      required this.onTap})
      : super(key: key);

  final String titleText, warningText, okText;
  final Function() onTap;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kTextColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 2.heightAdjusted),
                Text(widget.titleText,
                    textAlign: TextAlign.center, style: semiBoldText(fontSize: 18)),
                SizedBox(height: 2.heightAdjusted),
                const Divider(),
                SizedBox(height: 2.heightAdjusted),
                Text(widget.warningText,
                    textAlign: TextAlign.center,
                    style: regularText(fontSize: 16)),
                SizedBox(height: 8.heightAdjusted),
                Row(children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text('Cancel', style: regularText(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: GestureDetector(
                          onTap: widget.onTap,
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: kPrimaryBlue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(widget.okText,
                                  style: regularText(color: Colors.white)))))
                ])
              ]),
        ));
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/text_styles.dart';

import 'helpers.dart';

Future<DateTime?> calendarDatePicker({bool isBirthDate = false}) async {
  final now = DateTime.now();
  DateTime? selectedDateTime = DateTime(now.year, now.month, now.day);

  if (Platform.isAndroid) {
    selectedDateTime = await showDatePicker(
      context: buildContext,
      initialDate: isBirthDate ? DateTime(now.year - 18) : DateTime.now(),
      firstDate:
          isBirthDate ? DateTime(DateTime.now().year - 70) : DateTime.now(),
      lastDate: isBirthDate
          ? DateTime(now.year - 18, 12, 31)
          : DateTime(now.year, 12, 31),
    );

    return selectedDateTime;
  } else {
    await showCupertinoModalPopup(
        context: buildContext,
        builder: (_) => Container(
              height: MediaQuery.of(buildContext).size.height * 0.4,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        minimumDate: isBirthDate
                            ? DateTime(now.year - 70)
                            : DateTime.now(),
                        initialDateTime: isBirthDate
                            ? DateTime(now.year - 18)
                            : DateTime.now(),
                        maximumYear: isBirthDate
                            ? DateTime.now().year - 18
                            : DateTime.now().year,
                        onDateTimeChanged: (newDate) =>
                            selectedDateTime = newDate),
                  ),
                  CupertinoButton(
                      child: Text('OK', style: boldText(color: kPrimaryBlue)),
                      onPressed: () => Navigator.pop(buildContext)),
                  globalGap(4),
                ],
              ),
            ));

    return selectedDateTime;
  }
}

Future<DateTime> calendarTimePicker({DateTime? dateTime, String? title}) async {
  DateTime selectedTime = dateTime ?? DateTime.now();

  if (Platform.isAndroid) {
    var time = await showTimePicker(
        context: buildContext,
        initialTime: TimeOfDay.fromDateTime(selectedTime));

    if (time != null) {
      selectedTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, time.hour, time.minute);
    }

    return selectedTime;
  } else {
    await showCupertinoModalPopup(
        context: buildContext,
        builder: (_) => Container(
              height: MediaQuery.of(buildContext).size.height * 0.4,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: Column(
                children: [
                  if (title != null)
                    ...[
                      globalGap(2),
                      Material(child: Text(title, style: semiBoldText(fontSize: 18))),
                      globalGap(2),
                    ],
                  Expanded(
                      child: CupertinoDatePicker(
                          initialDateTime: selectedTime,
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (newDate) =>
                              selectedTime = newDate)),
                  CupertinoButton(
                      child: const Text('OK',
                          style: TextStyle(fontSize: 14, color: kPrimaryBlue)),
                      onPressed: () {
                        Navigator.pop(buildContext);
                      }),
                  globalGap(4),
                ],
              ),
            ));

    return selectedTime;
  }
}

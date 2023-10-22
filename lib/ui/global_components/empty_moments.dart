// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:simple_moments/utils/helpers.dart';
// import 'package:simple_moments/utils/text_styles.dart';
//
// class EmptyHistoryWidget extends StatelessWidget {
//   const EmptyHistoryWidget({
//     super.key,
//     required this.title,
//     required this.subTitle,
//     this.onTap,
//     this.btnText,
//   });
//
//   final String title, subTitle;
//   final Function()? onTap;
//   final String? btnText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 2,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SvgPicture.asset(emptyHistory),
//           globalGap(4),
//           Text(title, style: boldText(fontSize: 18)),
//           globalGap(2),
//           Text(
//             subTitle,
//             textAlign: TextAlign.center,
//             style: regularText(
//               color: kTextColor.withAlpha(190),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String get formatDate {
    final dateFormat = DateFormat('MMM d, ' 'yyyy');
    return dateFormat.format(this);
  }
}

extension StringExtensions on String {
  String get svg => 'assets/images/svg/$this.svg';

  String get png => 'assets/images/png/$this.png';

  String get lottie => 'assets/lottie/$this.json';

  String get cleanDate => replaceAll(RegExp('[A-Za-z]'), '').trim();

}


extension TimeAgo on DateTime {
  String timeAgo() {
    Duration diff = DateTime.now().difference(this);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "yr" : "yrs"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hr" : "hrs"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "mins"} ago";
    }
    return 'just now';
  }
}

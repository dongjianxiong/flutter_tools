import 'package:hz_tools/hz_tools.dart';

/// 字符串扩展
extension StringExtension on String {
  /// 判断是否包含数字，如包含则返回
  String get extractDigits {
    final RegExp digitRegex = RegExp(r'\d+');
    final Iterable<Match> matches = digitRegex.allMatches(this);

    if (matches.isNotEmpty) {
      final String digits = matches.map((match) => match.group(0)).join();
      return digits;
    } else {
      return 'null';
    }
  }

  /// 字符串转时间
  String formatDateStr({String format = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateUtil.formatDateStr(this, format: format);
  }

  /// 姓名组合
  /// 姓名显示第一个和最后一个字，中间字用“*”代替，两个字则只显示第一个字，其他字用“*”代替；
  String get formatName {
    if (length <= 2) {
      final String first = substring(0, 1);
      const String last = '*';
      return '$first$last';
    } else {
      final String first = substring(0, 1);
      final String last = substring(length - 1);
      const String middle = '*';
      return '$first$middle$last';
    }
  }
}

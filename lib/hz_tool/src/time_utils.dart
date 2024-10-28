import 'package:intl/intl.dart';

class TimeUtils {

  /// 用于显示的时间样式
  static String formatDepartTime(int timestamp) {
    // 根据时间戳的位数决定是否需要转换
    final time = timestamp.toString().length > 10 ? timestamp : timestamp * 1000;
    final targetDate = DateTime.fromMillisecondsSinceEpoch(time);
    final String formattedDate;

    if (_isToday(targetDate)) {
      // 今天
      formattedDate = DateFormat('HH:mm').format(targetDate);
    } else if (_isTomorrow(targetDate)) {
      // 明天
      formattedDate = '明天 ${DateFormat('HH:mm').format(targetDate)}';
    } else if (_isTheDayAfterTomorrow(targetDate)) {
      // 后天
      formattedDate = '后天 ${DateFormat('HH:mm').format(targetDate)}';
    } else {
      // 其他日期
      formattedDate = DateFormat('dd日 HH:mm').format(targetDate);
    }
    return formattedDate;
  }

  static bool _isToday(DateTime dateTime) {
    return _isSameDay(DateTime.now(), dateTime);
  }

  static bool _isTomorrow(DateTime dateTime) {
    return _isSameDay(dateTime, DateTime.now().add(const Duration(days: 1)));
  }

  static bool _isTheDayAfterTomorrow(DateTime dateTime) {
    return _isSameDay(dateTime, DateTime.now().add(const Duration(days: 2)));
  }

  static bool _isSameDay(DateTime src, DateTime target) {
    return src.year == target.year && src.month == target.month && src.day == target.day;
  }

  /// 用于语音播报的时间时间样式
  static String formatVoiceFriendlyDepartTime(int timestamp) {
    final time = timestamp.toString().length > 10 ? timestamp : timestamp * 1000;
    final targetDate = DateTime.fromMillisecondsSinceEpoch(time);

    final String formattedDate;

    if (_isToday(targetDate)) {
      // 今天
      formattedDate = '${DateFormat('HH').format(targetDate)}点${DateFormat('mm').format(targetDate)}分';
    } else if (_isTomorrow(targetDate)) {
      // 明天
      formattedDate = '明天 ${DateFormat('HH').format(targetDate)}点${DateFormat('mm').format(targetDate)}分';
    } else if (_isTheDayAfterTomorrow(targetDate)) {
      // 后天
      formattedDate = '后天 ${DateFormat('HH').format(targetDate)}点${DateFormat('mm').format(targetDate)}分';
    } else {
      // 其他日期
      formattedDate = DateFormat('MM月dd日 HH点mm分').format(targetDate);
    }

    return formattedDate;
  }

  /// 年月日时分
  static String formatYearMonthDayHourMinute(int timestamp) {
    var time = timestamp.toString().length > 10 ? timestamp : timestamp * 1000;
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  /// 年月日时分秒
  static String formatYearMonthDayHourMinuteSecond(int timestamp) {
    var time = timestamp.toString().length > 10 ? timestamp : timestamp * 1000;
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  ///  月日时分
  static String formatMonthDayHourMinute(int timestamp) {
    // 根据时间戳的位数决定是否需要转换
    var time = timestamp.toString().length > 10 ? timestamp : timestamp * 1000;
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    return DateFormat('MM月dd日 HH:mm').format(date);
  }
}

/*
   int的时候 直接用
   TimeUtils.formatDepartTime(data['departTime']);

   bookTimeStr为字符串的时候
   TimeUtils.formatDepartTime(int.tryParse(widget.bookTimeStr) ?? 0),


 */

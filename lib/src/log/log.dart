import 'package:logger/logger.dart';

enum HzLevel {
  all(0),
  trace(1000),
  debug(2000),
  info(3000),
  warning(4000),
  error(5000),
  fatal(6000),
  ;

  final int value;
  const HzLevel(this.value);
}

class HzLog {
  static Logger _logger = Logger(
    printer: _defaultPrinter,
    level: Level.all, // 可以根据环境设置不同的日志级别
  );

  static PrettyPrinter get _defaultPrinter => PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      );
  static const String _defTag = 'HzLog';
  static String _tagValue = _defTag;

  static setup(
    HzLevel level,
    String tag,
  ) {
    Level logLevel = Level.all;
    switch (level) {
      case HzLevel.all:
        logLevel = Level.all;
        break;
      case HzLevel.trace:
        logLevel = Level.trace;
        break;
      case HzLevel.debug:
        logLevel = Level.debug;
        break;
      case HzLevel.info:
        logLevel = Level.info;
        break;
      case HzLevel.warning:
        logLevel = Level.warning;
        break;
      case HzLevel.error:
        logLevel = Level.error;
        break;
      case HzLevel.fatal:
        logLevel = Level.fatal;
        break;
    }
    _tagValue = tag;
    _logger = Logger(level: logLevel, printer: _defaultPrinter);
  }

  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    message = '$_tagValue debug| $message';
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    message = '$_tagValue info| $message';
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    message = '$_tagValue warning| $message';
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    message = '$_tagValue error| $message';
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void t(String message, [dynamic error, StackTrace? stackTrace]) {
    message = '$_tagValue trace| $message';
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  static void f(String message, [dynamic error, StackTrace? stackTrace]) {
    message = '$_tagValue fatal| $message';
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

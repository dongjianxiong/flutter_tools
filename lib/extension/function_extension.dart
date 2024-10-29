import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hz_tools/hz_tools.dart';

extension FunctionExtension on Function {
  /// throttle：在每次调用之间需要等待 action 完成，确保在 action 结束前不会执行新的调用。
  VoidCallback throttle() {
    return FunctionProxy(this).throttle;
  }

  /// throttleWithTimeout：在每次调用之间需要等待指定的时间间隔（timeout），无论 action 是否完成，都不会立即允许新的调用。
  VoidCallback throttleWithTimeout({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).throttleWithTimeout;
  }

  /// debounce：在指定时间timeout内，防止短时间内的多次执行。
  VoidCallback debounce({int? timeout = 1000}) {
    final debouncer = Debouncer(this, timeout: timeout);
    return debouncer.run;
  }
}

class FunctionProxy {
  FunctionProxy(this.action, {int? timeout}) : timeout = timeout ?? 500;
  static final Map<String, bool> _funcThrottle = {};
  final Function? action;
  final int timeout;

//  在执行 action 之前检查是否允许执行（通过 _funcThrottle）。
//  如果允许执行，则设置 _funcThrottle[key] 为 false，阻止后续的执行。
//  调用 action 后，无论成功或失败，都会在 finally 中清除 _funcThrottle[key]，允许下一次执行。
  void throttle() async {
    final String key = identityHashCode(action).toString();
    final bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      try {
        await action?.call();
      } catch (e) {
        rethrow;
      } finally {
        _funcThrottle.remove(key);
      }
    }
  }

//  在执行 action 之前检查是否允许执行（通过 _funcThrottle）。
//  如果允许执行，则设置 _funcThrottle[key] 为 false，阻止后续的执行。
//  调用 action 后，通过 Timer 在指定时间（timeout）后清除 _funcThrottle[key]，允许下一次执行。
  void throttleWithTimeout() {
    final String key = identityHashCode(action).toString();
    final bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      Timer(Duration(milliseconds: timeout), () {
        _funcThrottle.remove(key);
      });
      action?.call();
    }
  }
}

class Debouncer {
  Debouncer(this.action, {int? timeout}) : timeout = timeout ?? 1000;
  final Function action;
  static final Map<String, Timer> _funcDebounce = {};
  // final Function? action;
  final int timeout;
  // 第一次点击立即返回，同时创建一个timer
  // 通过 Timer 判断判断是否在timeout时间内，防止短时间内多次调用。
  //  如果在冷却时间内再次调用该方法，则不会执行action，需要冷却时间之后点击才能执行
  void run() {
    final String key = identityHashCode(action).toString();
    Timer? timer = _funcDebounce[key];
    if (timer == null || !timer.isActive) {
      timer?.cancel();
      timer = Timer(Duration(milliseconds: timeout), () {
        final Timer? t = _funcDebounce.remove(key);
        t?.cancel();
      });
      _funcDebounce[key] = timer;
      action.call();
      return;
    } else {
      HzLog.d('重复点击了');
    }
  }
}

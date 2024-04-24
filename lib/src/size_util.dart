import 'dart:ui';

import 'package:flutter/widgets.dart';

/// 开发中常用的尺寸参数
class SizeUtil {
  static final SizeUtil instance = SizeUtil._instance();

  factory SizeUtil() => instance;

  SizeUtil._instance();

  /// 设备相关信息
  static FlutterView viewWindow =
      WidgetsBinding.instance.platformDispatcher.views.first;
  static Size sizeDevice = viewWindow.physicalSize;
  static double devicePixelRatio = viewWindow.devicePixelRatio;

  /// 导航栏高度
  final double heightAppBar = viewWindow.padding.top;
  final double heightBottom = viewWindow.padding.bottom;

  /// TabBar的默认高度
  final double heightTabBar = 46;

  ///获取屏幕宽度
  final double screenWidth = sizeDevice.width / devicePixelRatio;

  /// 获取屏幕高度
  final double screenHeight = sizeDevice.height / devicePixelRatio;
}

import 'dart:ui';

import 'package:flutter/material.dart';

/// 开发中常用的尺寸参数
class SizeUtil {
  static final SizeUtil instance = SizeUtil._instance();

  factory SizeUtil() => instance;

  SizeUtil._instance();

  /// 设备相关信息
  // static FlutterView viewWindow =
  //     WidgetsBinding.instance.platformDispatcher.views.first;
  static FlutterView viewWindow = PlatformDispatcher.instance.implicitView!;
  static Size sizeDevice = viewWindow.physicalSize;
  static double devicePixelRatio = viewWindow.devicePixelRatio;

  ///获取屏幕宽度
  static final double screenWidth = sizeDevice.width / devicePixelRatio;

  /// 获取屏幕高度
  static final double screenHeight = sizeDevice.height / devicePixelRatio;

  /// 导航栏高度
  static final double appBarHeight = AppBar().preferredSize.height;

  /// 状态栏高度
  static final double statusBarHeight = viewWindow.padding.top / viewWindow.devicePixelRatio;

  /// 底部安全高度
  static final double bottomPadding = viewWindow.padding.bottom / viewWindow.devicePixelRatio;

  /// TabBar的默认高度
  static const double heightTabBar = 46;

  static final ViewPadding viewInsets = viewWindow.viewInsets;
  static final double viewInsetTop = viewInsets.top / viewWindow.devicePixelRatio;
  static final double viewInsetBottom = viewInsets.bottom / viewWindow.devicePixelRatio;
}

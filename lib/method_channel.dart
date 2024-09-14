import 'dart:io';

import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core_constants.dart';

/// An implementation of [CorePluginPlatform] that uses method channels.
class MethodChannelCorePlugin extends CorePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('itbox_core_plugin');

  late SharedPreferences prefs;

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    methodChannel.setMethodCallHandler(onMethodCall);
  }

  Future<dynamic> onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onLifecycleChanged':
        final state = AppLifecycleState.fromState(call.arguments['state']);
        AppLifecycleBinding.instance.dispatchLocalesChanged(state);
        break;
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// 获取app版本号
  @override
  Future<String?> getAppVersionName() async {
    try {
      final String result =
          (await methodChannel.invokeMethod<String>('getAppVersionName')) as String;
      return result;
    } catch (e) {
      return '1.0.0';
    }
  }

  /// 获取APP设备Id
  @override
  Future<String?> getDeviceId() async {
    try {
      final String result = (await methodChannel.invokeMethod<String>('getDeviceId')) as String;
      return result;
    } catch (e) {
      return '';
    }
  }

  ///合规初始化
  @override
  Future<String> complianceInit() async {
    try {
      setProtocol(true);
      if (Platform.isAndroid) {
        final String result =
            (await methodChannel.invokeMethod<String>('complianceInit')) as String;
        return result;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  ///主动初始化
  @override
  Future<String> activeInit() async {
    try {
      if (Platform.isAndroid) {
        final String result = (await methodChannel.invokeMethod<String>('activeInit')) as String;
        return result;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  ///是否同意协议
  @override
  bool isProtocolAgree() {
    final bool? agree = prefs.getBool(CoreConstants.agreeKey);
    return agree == true;
  }

  ///设置协议状态
  @override
  void setProtocol(bool agree) {
    prefs.setBool(CoreConstants.agreeKey, agree);
  }

  @override
  Future<String> getFlavorsName() async {
    try {
      if (Platform.isAndroid) {
        final String result =
            (await methodChannel.invokeMethod<String>('getFlavorsName')) as String;
        return result;
      } else if (Platform.isIOS) {
        return 'AppStore';
      } else {
        return 'unknown';
      }
    } catch (e) {
      return 'unknown';
    }
  }
}

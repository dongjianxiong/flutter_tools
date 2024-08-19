import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core_constants.dart';
import 'core_plugin_platform_interface.dart';

/// An implementation of [CorePluginPlatform] that uses method channels.
class MethodChannelCorePlugin extends CorePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('itbox_core_plugin');

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
  Future<bool> isProtocolAgree() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? agree = prefs.getBool(CoreConstants.agreeKey);
    return agree == true;
  }

  ///设置协议状态
  @override
  Future<void> setProtocol(bool agree) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(CoreConstants.agreeKey, agree);
  }
}

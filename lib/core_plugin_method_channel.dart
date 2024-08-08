import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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
      final String result = (await methodChannel.invokeMethod<String>(
          'getAppVersionName')) as String;
      return result;
    } catch (e) {
      return '1.0.0';
    }
  }


  /// 获取APP设备Id
  @override
  Future<String?> getDeviceId() async {
    try {
      final String result = (await methodChannel.invokeMethod<String>(
          'getDeviceId')) as String;
      return result;
    } catch (e) {
      return '';
    }
  }

  ///合规初始化
  @override
  Future<String> complianceInit(bool isDebug) async{
    try {
      final String result = (await methodChannel.invokeMethod<String>(
          'complianceInit',isDebug)) as String;
      return result;
    } catch (e) {
      return '';
    }
  }
}

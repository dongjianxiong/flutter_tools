import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core_plugin_method_channel.dart';

abstract class CorePluginPlatform extends PlatformInterface {
  /// Constructs a CorePluginPlatform.
  CorePluginPlatform() : super(token: _token) {
    init();
  }

  static final Object _token = Object();

  late SharedPreferences prefs;

  static CorePluginPlatform _instance = MethodChannelCorePlugin();

  /// The default instance of [CorePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelCorePlugin].
  static CorePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CorePluginPlatform] when
  /// they register themselves.
  static set instance(CorePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getAppVersionName() {
    throw UnimplementedError('getAppVersionName() has not been implemented.');
  }

  Future<String?> getDeviceId() {
    throw UnimplementedError('getDeviceId() has not been implemented.');
  }

  Future<String?> complianceInit() {
    throw UnimplementedError('complianceInit() has not been implemented.');
  }

  Future<String?> activeInit() {
    throw UnimplementedError('activeInit() has not been implemented.');
  }

  bool isProtocolAgree() {
    throw UnimplementedError('isProtocolAgree() has not been implemented.');
  }

  void setProtocol(bool agree) {
    throw UnimplementedError('setProtocol() has not been implemented.');
  }

  Future<String> getFlavorsName() {
    throw UnimplementedError('getFlavorsName() has not been implemented.');
  }
}

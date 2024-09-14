// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:core_plugin/platform_interface.dart';

export 'package:core_plugin/lifecycle/app_lifecycle.dart';
export 'package:core_plugin/lifecycle/observer.dart';

class CorePlugin {
  static Future<void> init() async {
    return CorePluginPlatform.instance.init();
  }

  static Future<String?> getPlatformVersion() {
    return CorePluginPlatform.instance.getPlatformVersion();
  }

  static Future<String?> getAppVersionName() {
    return CorePluginPlatform.instance.getAppVersionName();
  }

  static Future<String?> getDeviceId() {
    return CorePluginPlatform.instance.getDeviceId();
  }

  static Future<String?> complianceInit() {
    return CorePluginPlatform.instance.complianceInit();
  }

  static Future<String?> activeInit() {
    return CorePluginPlatform.instance.activeInit();
  }

  static bool isProtocolAgree() {
    return CorePluginPlatform.instance.isProtocolAgree();
  }

  static void setProtocol(bool agree) {
    return CorePluginPlatform.instance.setProtocol(agree);
  }

  static Future<String> getFlavorsName() {
    return CorePluginPlatform.instance.getFlavorsName();
  }
}

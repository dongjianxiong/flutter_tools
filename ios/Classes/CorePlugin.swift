import Flutter
import UIKit

struct CorePluginStruct {
    static let itboxCorePlugin = "itbox_core_plugin"
    static let getPlatformVersion = "getPlatformVersion"
    static let getAppVersionName = "getAppVersionName"
    static let getDeviceId = "getDeviceId"

}

public class CorePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: CorePluginStruct.itboxCorePlugin, binaryMessenger: registrar.messenger())
    let instance = CorePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case CorePluginStruct.getPlatformVersion:
      result("iOS " + UIDevice.current.systemVersion)
        break
    case CorePluginStruct.getAppVersionName:
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        result(version)
        break
    case CorePluginStruct.getDeviceId:
        // 获取设备id
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        result(deviceId)
        break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}


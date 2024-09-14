import Flutter
import UIKit

let CPItboxCorePluginCnanelName = "itbox_core_plugin"

// flutter=>Native
let CPGetPlatformVersionMethod = "getPlatformVersion"
let CPGetAppVersionNameMethod = "getAppVersionName"
let CPGetDeviceIdMethod = "getDeviceId"

public class CorePlugin: NSObject, FlutterPlugin {
    
    
    var channel: FlutterMethodChannel!
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CPItboxCorePluginCnanelName, binaryMessenger: registrar.messenger())
        let instance = CorePlugin()
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
        instance.channel = channel
        registrar.publish(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case CPGetPlatformVersionMethod:
          result("iOS " + UIDevice.current.systemVersion)
            break
        case CPGetAppVersionNameMethod:
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            result(version)
            break
        case CPGetDeviceIdMethod:
            // 获取设备id
            let deviceId = UIDevice.current.identifierForVendor?.uuidString
            result(deviceId)
            break
        default:
          result(FlutterMethodNotImplemented)
        }
    }
    
    deinit {
//        print("CorePlugin 销毁")
    }
}




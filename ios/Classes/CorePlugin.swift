import Flutter
import UIKit

struct CorePluginStruct {
    static let itboxCorePlugin = "itbox_core_plugin"
    static let getPlatformVersion = "getPlatformVersion"
    static let getAppVersionName = "getAppVersionName"
    static let getDeviceId = "getDeviceId"

}

public class CorePlugin: NSObject, FlutterPlugin {
    
    
    var channel: FlutterMethodChannel!
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CorePluginStruct.itboxCorePlugin, binaryMessenger: registrar.messenger())
        let instance = CorePlugin()
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
        instance.channel = channel
        registrar.publish(instance)

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
    
    deinit {
//        print("CorePlugin 销毁")
    }
}




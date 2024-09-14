import Flutter
import UIKit

struct CorePluginStruct {
    static let itboxCorePlugin = "itbox_core_plugin"
    static let getPlatformVersion = "getPlatformVersion"
    static let getAppVersionName = "getAppVersionName"
    static let getDeviceId = "getDeviceId"

}


public class CorePluginWeakDictionary<Key: AnyObject, Value: AnyObject> {
    public let mapTable: NSMapTable<Key, Value>

    init() {
        mapTable = NSMapTable<Key, Value>(
            keyOptions: .weakMemory,
            valueOptions: .weakMemory,
            capacity: 0
        )
    }

    subscript(key: Key) -> Value? {
        get { return mapTable.object(forKey: key) }
        set { mapTable.setObject(newValue, forKey: key) }
    }

    public func object(forKey: Key?) {
        mapTable.object(forKey: forKey)
    }

    public func removeObject(forKey: Key?) {
        mapTable.removeObject(forKey: forKey)
    }

    public func count() -> Int {
        return mapTable.count
    }

    public func allObjects() -> [Value]? {
        return mapTable.objectEnumerator()?.allObjects as? [Value]
    }
}


public class CorePlugin: NSObject, FlutterPlugin {
    
    
    var channel: FlutterEventChannel!
    var registrar: FlutterPluginRegistrar!

    static var channelHolders = CorePluginWeakDictionary<CorePlugin, FlutterMethodChannel>.init()
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: CorePluginStruct.itboxCorePlugin, binaryMessenger: registrar.messenger())
    let instance = CorePlugin()
      registrar.addApplicationDelegate(instance)
      registrar.publish(instance)
    registrar.addMethodCallDelegate(instance, channel: channel)
      channelHolders[instance] = channel
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
        print("CorePlugin 销毁")
    }
}


extension CorePlugin: UIApplicationDelegate {
     

    // 拦截 AppDelegate 的生命周期事件
    public func applicationDidBecomeActive(_ application: UIApplication) {
       // 处理应用进入前台事件
       print("App became active from AppDelegate")
        if let channel = CorePlugin.channelHolders[self] {
            channel.invokeMethod("onAppLifecycleStateChanged", arguments: "foreground")
        }
    }

    public func applicationDidEnterBackground(_ application: UIApplication) {
       // 处理应用进入后台事件
       print("App entered background from AppDelegate")
        if let channel = CorePlugin.channelHolders[self] {
            channel.invokeMethod("onAppLifecycleStateChanged", arguments: "background")
        }
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        // 应用将进入非活跃状态
        print("App will resign active from AppDelegate")
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        // 处理应用进入后台事件
        print("App will terminate from AppDelegate")
    }

    public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        // 处理应用进入后台事件
        print("App did received memory warning from AppDelegate")
    }

//    UIApplication.willResignActiveNotification: 应用将进入非活跃状态。
//    UIApplication.willTerminateNotification: 应用将被终止。
 }



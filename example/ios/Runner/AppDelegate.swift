import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let rootVc = self.window.rootViewController!
      let navi = UINavigationController.init(rootViewController: rootVc)
      self.window.rootViewController = navi
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
          let flutterVc = FlutterViewController.init()
          navi.pushViewController(flutterVc, animated: true)
          GeneratedPluginRegistrant.register(with: flutterVc.pluginRegistry())
      }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

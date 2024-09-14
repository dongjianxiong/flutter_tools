//
//  CorePluginLifecycle.swift
//  core_plugin
//
//  Created by itbox_djx on 2024/9/14.
//

import Foundation

// native=>flutter
let CPOnLifecycleChangedMethod = "onLifecycleChanged"


extension CorePlugin: UIApplicationDelegate {
     

    // 拦截 AppDelegate 的生命周期事件
    public func applicationDidBecomeActive(_ application: UIApplication) {
        // 处理应用进入前台事件
        print("App became active from AppDelegate")
        if let channel = self.channel {
            channel.invokeMethod(CPOnLifecycleChangedMethod, arguments: ["state":"foreground"])
        }
    }

    public func applicationDidEnterBackground(_ application: UIApplication) {
       // 处理应用进入后台事件
       print("App entered background from AppDelegate")
        if let channel = self.channel {
            channel.invokeMethod(CPOnLifecycleChangedMethod, arguments: ["state":"background"])
        }
    }

//    public func applicationWillResignActive(_ application: UIApplication) {
//        // 应用将进入非活跃状态
//        print("App will resign active from AppDelegate")
//    }
//
//    public func applicationWillTerminate(_ application: UIApplication) {
//        // 处理应用进入后台事件
//        print("App will terminate from AppDelegate")
//    }
//
//    public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
//        // 处理应用进入后台事件
//        print("App did received memory warning from AppDelegate")
//    }

//    UIApplication.willResignActiveNotification: 应用将进入非活跃状态。
//    UIApplication.willTerminateNotification: 应用将被终止。
 }


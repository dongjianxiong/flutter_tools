package cn.itbox.core_plugin

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.UUID

/** CorePlugin */
class CorePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var context: Context? = null


  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "itbox_core_plugin")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getAppVersionName") {
      context?.let {
        try {
          val packageInfo: PackageInfo = it.packageManager.getPackageInfo(it.packageName, 0)
          result.success(packageInfo.versionName)
        } catch (e: PackageManager.NameNotFoundException) {
          e.printStackTrace()
        }
      }
      if (context != null) {
      }
    } else if (call.method == "getDeviceId") {
      context?.let {
        val prefs = it.getSharedPreferences("app-device-info", Context.MODE_PRIVATE)
        val deviceId = prefs.getString("deviceId", null)
        if (deviceId?.isNotEmpty() == true) {
          result.success(deviceId)
        } else {
          val androidID =
            Settings.System.getString(it.contentResolver, Settings.Secure.ANDROID_ID)
          val id = if (androidID?.isNotEmpty() == true) {
            androidID
          } else {
            UUID.randomUUID().toString()
          }
          prefs.edit().putString("deviceId", id).apply()
          result.success(id)
        }
      }
      if (context != null) {
      }
    } else if(call.method == "complianceInit"){
      CoreEngine.delegate?.onComplianceInit(call.arguments as Boolean)
    }else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

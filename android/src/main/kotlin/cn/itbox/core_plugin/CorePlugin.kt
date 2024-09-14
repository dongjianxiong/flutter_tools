package cn.itbox.core_plugin

import android.app.Application
import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull
import cn.itbox.core_plugin.lifecycle.LifecycleInjector

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.UUID

/** CorePlugin */
class CorePlugin : FlutterPlugin, MethodCallHandler {

    private var context: Context? = null

    companion object {

        private val channels = mutableMapOf<Int, MethodChannel>()

        internal fun dispatchLifecycleEvent(isForeground: Boolean) {
            channels.values.forEach { channel ->
                kotlin.runCatching {
                    val args = mapOf("state" to if (isForeground) "foreground" else "background")
                    channel.invokeMethod("onLifecycleChanged", args)
                }
            }
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        LifecycleInjector.inject(flutterPluginBinding.applicationContext as Application)

        val channel = MethodChannel(flutterPluginBinding.binaryMessenger, "itbox_core_plugin")
        channel.setMethodCallHandler(this)

        channels[flutterPluginBinding.hashCode()] = channel
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getAppVersionName" || call.method == "getPlatformVersion") {
            context?.let {
                try {
                    val packageInfo: PackageInfo =
                        it.packageManager.getPackageInfo(it.packageName, 0)
                    result.success(packageInfo.versionName)
                } catch (e: PackageManager.NameNotFoundException) {
                    e.printStackTrace()
                }
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
        } else if (call.method == "complianceInit") {
            CoreEngine.delegate?.onComplianceInit()
        } else if (call.method == "activeInit") {
            CoreEngine.delegate?.activeInit()
        } else if(call.method == "getFlavorsName"){
            result.success(getFlavorsName())
        }else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channels.remove(binding.hashCode())?.also {
            it.setMethodCallHandler(null)
        }
    }

    private fun getFlavorsName(): String? {
        val packageManager = context?.packageManager
        val packageName = context?.packageName

        // 直接尝试获取 ApplicationInfo，并处理异常
        return try {
            val applicationInfo =
                packageName?.let { packageManager?.getApplicationInfo(it, PackageManager.GET_META_DATA) }
            applicationInfo?.metaData?.getString("UMENG_CHANNEL") ?: "unknown"
        } catch (e: PackageManager.NameNotFoundException) {
            // 记录异常信息
            Log.e("getChannel", "Failed to find package name: ${e.message}")
            "unknown"
        }
    }
}

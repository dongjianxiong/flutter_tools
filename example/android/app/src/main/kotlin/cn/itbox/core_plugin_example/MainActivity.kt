package cn.itbox.core_plugin_example

import io.flutter.embedding.android.FlutterActivity
import cn.itbox.core_plugin.CoreDelegate
import cn.itbox.core_plugin.CoreEngine
import android.util.Log


class MainActivity: FlutterActivity(){

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        CoreEngine.init(object : CoreDelegate {
            override fun onComplianceInit(isDebug: Boolean) {
                Log.e("合规性", "这里进行初始化$isDebug")
            }
        })
    }
}
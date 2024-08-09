package cn.itbox.core_plugin_example

import android.app.Application
import android.util.Log
import cn.itbox.core_plugin.CoreDelegate
import cn.itbox.core_plugin.CoreEngine

class ExampleApplication: Application(),CoreDelegate{

    override fun onCreate() {
        super.onCreate()
        CoreEngine.init(this,this)

        //
        if(CoreEngine.isProtocolAgree()){
            Log.e("合规","主动")
            activeInit()
        }
    }

    override fun onComplianceInit() {
        Log.e("合规","onComplianceInit")
    }

    override fun activeInit() {
        Log.e("合规","activeInit")
    }
}
package cn.itbox.core_plugin

import android.content.Context
import java.lang.ref.WeakReference

object CoreEngine {
    private var _delegate: CoreDelegate? = null
    private var _contextRef: WeakReference<Context>? = null

    internal val delegate get() = _delegate

    fun init(delegate: CoreDelegate,context: Context) {
        _delegate = delegate
        _contextRef = WeakReference(context)
    }

    fun isProtocolAgree(): Boolean{
        if(_contextRef == null) return false
        val prefs = _contextRef?.get()?.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val agreeProtocol = prefs?.getBoolean("flutter.hzAgreedPrivacyAgreement", false)
        return agreeProtocol == true
    }
}
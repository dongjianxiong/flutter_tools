package cn.itbox.core_plugin.lifecycle

import android.app.Activity
import android.app.Application
import android.os.Bundle
import android.util.Log
import cn.itbox.core_plugin.CorePlugin

internal object LifecycleInjector {

    private var isInit = false

    fun inject(application: Application) {
        if (isInit) return
        application.registerActivityLifecycleCallbacks(AppLifecycleHandler())
        isInit = true
    }

    private class AppLifecycleHandler : Application.ActivityLifecycleCallbacks {
        private val tag = "AppLifecycleHandler"
        private var activityReferences = 0
        private var isActivityChangingConfigurations = false

        override fun onActivityCreated(
            activity: Activity,
            savedInstanceState: Bundle?
        ) {
        }

        override fun onActivityStarted(activity: Activity) {
            if (++activityReferences == 1 && !isActivityChangingConfigurations) {
                // 应用进入前台
                Log.d(tag, "App entered foreground")
                CorePlugin.dispatchLifecycleEvent(true)
            }
        }

        override fun onActivityResumed(activity: Activity) {
        }

        override fun onActivityPaused(activity: Activity) {
        }

        override fun onActivityStopped(activity: Activity) {
            isActivityChangingConfigurations = activity.isChangingConfigurations
            if (--activityReferences == 0 && !isActivityChangingConfigurations) {
                // 应用进入后台
                Log.d(tag, "App entered background")
                CorePlugin.dispatchLifecycleEvent(false)
            }
        }

        override fun onActivitySaveInstanceState(
            activity: Activity,
            outState: Bundle
        ) {
        }

        override fun onActivityDestroyed(activity: Activity) {
        }

    }
}
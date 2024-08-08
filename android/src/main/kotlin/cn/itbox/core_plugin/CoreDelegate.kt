package cn.itbox.core_plugin

interface CoreDelegate {

    /**
     * 合规初始化
     */
    fun onComplianceInit(isDebug: Boolean)
}
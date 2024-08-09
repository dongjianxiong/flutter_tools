package cn.itbox.core_plugin

interface CoreDelegate {

    /**
     * 同意隐私政策后合规初始化
     */
    fun onComplianceInit()


    /**
     * 主动初始化
     */
    fun activeInit()
}
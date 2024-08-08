package cn.itbox.core_plugin

object CoreEngine {
    private var _delegate: CoreDelegate? = null

    internal val delegate get() = _delegate

    fun init(delegate: CoreDelegate) {
        _delegate = delegate
    }
}
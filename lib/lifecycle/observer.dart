// iOS 应用的生命周期由一系列事件驱动，主要由应用在不同状态之间的过渡决定。每个状态对应不同的生命周期回调，可以在这些回调中执行特定的操作。iOS 的生命周期主要涉及以下几个关键状态：
//
// 1. Not Running（未运行）
// 当应用未启动或被系统关闭时，应用处于未运行状态。在这个状态下，应用不在内存中，所有的进程和任务都停止。
//
// 2. Inactive（非活跃状态）
// 应用正在前台运行，但未接收事件或交互。例如，当用户接到电话或正在锁屏状态下时，应用处于 Inactive 状态。
//
// 回调：
// applicationWillResignActive:
// 当应用将要从活跃状态进入非活跃状态时调用。可以在此暂停正在进行的任务、禁用定时器，或者降低 OpenGL ES 帧率等操作。
// 3. Active（活跃状态）
// 应用在前台并处于活跃状态，能够正常接收用户输入和交互。此状态是用户与应用交互的主要状态。
//
// 回调：
// applicationDidBecomeActive:
// 当应用从 Inactive 状态进入 Active 状态时调用。可以在这里恢复暂停的任务，或者刷新 UI。
// 4. Background（后台状态）
// 当用户按下主屏按钮或打开其他应用时，应用会进入后台状态。此时应用仍在内存中，可以执行一些后台任务，但无法与用户交互。
//
// 回调：
// applicationDidEnterBackground:
// 当应用进入后台时调用。此处适合保存数据、释放共享资源、保存应用状态，以防应用被系统终止。
//
// applicationWillEnterForeground:
// 在应用从后台状态返回前台时调用。可以在此恢复应用的状态，为重新进入活跃状态做准备。
//
// 5. Suspended（挂起状态）
// 应用在后台无法执行代码，处于挂起状态。此状态下，应用仍然驻留在内存中，但不会消耗 CPU 资源。系统可以根据内存需求随时终止挂起的应用。
//
// 应用程序在后台如果没有执行任何后台任务，通常会很快进入挂起状态。
//
// 常见生命周期回调函数：
// application:didFinishLaunchingWithOptions:
// 在应用完成启动时调用。此方法适合执行应用的初始配置，比如设置数据库，初始化第三方库，或者加载关键数据。
//
// applicationWillResignActive:
// 当应用即将从活跃状态转为非活跃状态时调用，通常因为电话呼入或者按下 Home 键。
//
// applicationDidEnterBackground:
// 当应用完全进入后台时调用。应用需要在此保存数据、释放资源、处理后台任务等。
//
// applicationWillEnterForeground:
// 当应用即将从后台进入前台时调用。此时应用尚未处于活跃状态。
//
// applicationDidBecomeActive:
// 当应用已经处于活跃状态时调用，可以重新启动暂停的任务或更新界面。
//
// applicationWillTerminate:
// 当应用即将被系统终止时调用，适合进行清理工作或保存数据。
//
// 典型生命周期流程：
// 启动阶段：应用从未运行状态到活跃状态，依次会经历 didFinishLaunchingWithOptions -> applicationDidBecomeActive。
// 进入后台：用户按下 Home 键或切换到其他应用时，应用经历 applicationWillResignActive -> applicationDidEnterBackground。
// 回到前台：应用再次被打开，经历 applicationWillEnterForeground -> applicationDidBecomeActive。
// 终止：如果应用在后台被系统终止，调用 applicationWillTerminate，不过这个不一定总是被调用，尤其在后台被杀死时。
// enum AppLifecycleState {
//   forground,
//   background,
//   inActivative,
//   detached,
// }

mixin AppLifecycleObserver {
  // void didChangeAppLifecycleState(AppLifecycleState state) {}

  void onBackground() {}

  void onForeground() {}
}

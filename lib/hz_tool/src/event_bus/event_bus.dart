//订阅者回调签名
typedef EventCallback = void Function(dynamic arg);

///事件总线
class EventBus {
  // 工厂方法构造函数 - 通过UserModel()获取对象
  factory EventBus() => _getInstance();

  // instance的getter方法 - 通过UserModel.instance获取对象2
  static EventBus get instance => _getInstance();

  // 静态变量_instance，存储唯一对象
  static EventBus? _instance;

  // 获取唯一对象
  static EventBus _getInstance() {
    _instance ??= EventBus._internal();
    return _instance!;
  }

  //初始化...
  EventBus._internal() {
    //初始化其他操作...
  }

  ///以上为单例...

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  final _map = <Object, List<EventCallback>>{};

  ///添加订阅者-接收事件
  void addListener(eventName, EventCallback f) {
    if (eventName == null) return;
    _map[eventName] ??= <EventCallback>[];
    _map[eventName]?.add(f);
  }

  ///移除订阅者-结束事件
  void removeListener({required String eventName, EventCallback? f}) {
    var list = _map[eventName];
    if (eventName.isEmpty || list == null) return;
    if (f == null) {
      _map.remove(eventName);
    } else {
      list.remove(f);
    }
  }

  ///已加订阅者-发送事件
  void commit({required String eventName, dynamic data}) {
    var list = _map[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止在订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](data);
    }
  }
}

/// 定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
var bus = EventBus();

/// 司机入职页面查询司机入职流程信息
const String queryEntryProcessEvent = "query_entry_process_event";
/// 司机登录成功
const String driverLoginSuccessEvent = "driver_login_success_event";
/// 行程列表页面刷新
const String itineraryRefreshEvent = "itinerary_refresh_event";
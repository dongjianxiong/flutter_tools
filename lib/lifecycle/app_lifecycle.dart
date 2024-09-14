import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'observer.dart';

enum AppLifecycleState {
  foreground(1),
  background(2);

  const AppLifecycleState(this.state);
  final int state;

  static AppLifecycleState fromState(dynamic state) {
    return AppLifecycleState.values.firstWhere(
      (element) => element.state == state,
      orElse: () => AppLifecycleState.foreground,
    );
  }
}

class AppLifecycleBinding {
  static final AppLifecycleBinding _instance = AppLifecycleBinding._();
  factory AppLifecycleBinding() => _instance;

  static AppLifecycleBinding get instance => _instance;
  AppLifecycleBinding._() {
    _channel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'onAppLifecycleStateChanged':
          debugPrint('[INFO] [AppLifecycleState] onAppLifecycleStateChanged: ${call.arguments}');
          assert(call.arguments is int);
          int sate = call.arguments as int? ?? 1;
          _handleAppLifecycleStateChanged(AppLifecycleState.fromState(sate));
          break;
      }
      return Future<void>.value();
    });
  }
  bool get isInForeground => _state == AppLifecycleState.foreground;

  final AppLifecycleState _state = AppLifecycleState.foreground;

  final MethodChannel _channel = const MethodChannel('itbox_core_plugin');

  void _handleAppLifecycleStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.foreground:
        debugPrint('[INFO] [AppLifecycleState] App is foreground');
        break;
      case AppLifecycleState.background:
        debugPrint('[INFO] [AppLifecycleState] App is background');
        break;
    }
    dispatchLocalesChanged(state);
  }

  final List<AppLifecycleObserver> _observers = <AppLifecycleObserver>[];

  void addObserver(AppLifecycleObserver observer) => _observers.add(observer);

  bool removeObserver(AppLifecycleObserver observer) => _observers.remove(observer);

  @protected
  void dispatchLocalesChanged(AppLifecycleState state) {
    for (final AppLifecycleObserver observer in _observers) {
      if (state == AppLifecycleState.foreground) {
        observer.onForeground();
      } else if (state == AppLifecycleState.background) {
        observer.onBackground();
      } else {
        print('[WARNING] Unknown AppLifecycleState: $state');
      }
    }
  }
}

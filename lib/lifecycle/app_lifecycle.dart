import 'package:flutter/foundation.dart';

import 'observer.dart';

enum AppLifecycleState {
  foreground('foreground'),
  background('background');

  const AppLifecycleState(this.state);
  final String state;

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
  AppLifecycleBinding._() {}

  bool get isInForeground => _state == AppLifecycleState.foreground;

  AppLifecycleState _state = AppLifecycleState.foreground;

  final List<NativeAppLifecycleObserver> _observers = <NativeAppLifecycleObserver>[];

  void addObserver(NativeAppLifecycleObserver observer) {
    if (!_observers.contains(observer)) {
      _observers.add(observer);
    }
  }

  bool removeObserver(NativeAppLifecycleObserver observer) => _observers.remove(observer);

  void dispatchLocalesChanged(AppLifecycleState state) {
    _state = state;
    debugPrint('[INFO] [AppLifecycleState] App lifecycle state changed: $state');
    for (final NativeAppLifecycleObserver observer in _observers) {
      if (state == AppLifecycleState.foreground) {
        observer.onForeground();
      } else if (state == AppLifecycleState.background) {
        observer.onBackground();
      } else {
        debugPrint('[WARNING] Unknown AppLifecycleState: $state');
      }
    }
  }
}

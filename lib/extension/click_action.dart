import 'package:flutter/cupertino.dart';

/// 给组件添加点击事件
extension ClickAbleWidget<T> on Widget {
  Widget withOnClick({required void Function(T?) onTap, T? argument}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(argument),
      child: this,
    );
  }
}

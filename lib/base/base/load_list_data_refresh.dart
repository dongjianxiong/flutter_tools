import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_list_data_provider.dart';

mixin LoadListDataRefresh<T> on BaseListDataProvider<T> {
  /// 刷新控制器
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  /// 业务逻辑控制器
  Widget smartRefresh(BuildContext context,
      {bool? showLoading,
      bool? showRefresh,
      bool? showLoadMore = true,
      bool? showEmpty,
      required Widget child}) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: showRefresh ?? true,
      onRefresh: () {
        refresh(showLoading: showLoading, showEmpty: showEmpty);
      },
      onLoading: loadMore,
      enablePullUp: showLoadMore ?? true,
      child: child,
    );
  }

  void refresh({bool? showLoading, bool? showEmpty}) {
    refreshData().then((value) {
      if (isFailed) {
        refreshController.refreshFailed();
      } else {
        refreshController.refreshCompleted();
      }
    });
  }

  void loadMore() {
    loadMoreData().then((value) {
      if (isFailed) {
        refreshController.loadFailed();
      } else {
        if (!hasMore) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }
    });
  }
}

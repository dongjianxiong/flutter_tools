import 'package:flutter/material.dart';
import 'package:hz_ui/hz_ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_list_data_provider.dart';

mixin LoadListDataContainer<T> on BaseListDataProvider<T> {
  /// 刷新控制器
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  /// 占位 、loading 、报错 的基础界面
  final HzPageContainerController containerController = HzPageContainerController();

  Widget smartRefresh(
    BuildContext context, {
    bool? showLoading,
    bool? showEmpty,
    bool? showLoadMore = true,
    required Widget child,
  }) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: () {
        refresh(showLoading: showLoading, showEmpty: showEmpty);
      },
      onLoading: loadMore,
      enablePullUp: showLoadMore ?? true,
      child: child,
    );
  }

  void refresh({bool? showLoading, bool? showEmpty}) {
    if (showLoading == true) {
      containerController.showLoading();
    }
    refreshData().then((value) {
      if (isFailed) {
        containerController.showNetworkError();
        refreshController.refreshFailed();
      } else {
        refreshController.refreshCompleted(resetFooterState: true);
        if (isEmpty) {
          containerController.showEmpty(showEmpty ?? true);
        } else {
          containerController.showContentView();
          if (hasMore) {
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        }
      }
    });
  }

  void loadMore() {
    loadMoreData().then(
      (value) {
        if (isFailed) {
          refreshController.loadFailed();
        } else if (hasMore) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      },
    );
  }
}

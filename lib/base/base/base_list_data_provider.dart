import 'package:flutter/cupertino.dart';

import 'data_load_status.dart';
import 'net_response_data.dart';

enum ListDataLoadType {
  firstLoad,
  refresh,
  loadMore,
}

class BaseListDataProvider<T> with ChangeNotifier {
  ListDataLoadType loadType = ListDataLoadType.firstLoad;
  int currentPage = 1;
  int pageSize = 20;
  List<T> dataList = [];

  bool _isFirst = true;

  DataLoadStatus _status = DataLoadStatus.initial;
  set status(DataLoadStatus value) {
    _status = value;
    reloadData();
  }

  DataLoadStatus get status => _status;

  // bool get hasMore =>
  //     status == DataLoadStatus.succeed || (currentPage > 1 && status == DataLoadStatus.failed);

  bool _hasMore = false;
  set hasMore(bool value) {
    _hasMore = value;
    reloadData();
  }

  bool get hasMore => _hasMore;

  bool get isLoading => _status == DataLoadStatus.loading;
  bool get isEmpty => dataList.isEmpty && _status == DataLoadStatus.empty;
  bool get isSucceed => _status == DataLoadStatus.succeed;
  bool get isFailed => _status == DataLoadStatus.failed;

  Future<void> refreshData() async {
    if (loadType != ListDataLoadType.loadMore && status == DataLoadStatus.loading) {
      return;
    }
    if (_isFirst == true) {
      _isFirst = false;
    } else {
      loadType = ListDataLoadType.refresh;
    }
    currentPage = 1;
    status = DataLoadStatus.loading;
    final NetResponseData<List<T>> res = await loadData();
    if (res.success) {
      dataList.clear();
      if (res.data != null && res.data is List && res.data!.isNotEmpty) {
        dataList.addAll(res.data!);
        status = DataLoadStatus.succeed;
      } else {
        status = DataLoadStatus.empty;
      }
    } else {
      status = DataLoadStatus.failed;
    }
    return;
  }

  Future<void> loadMoreData() async {
    if (status == DataLoadStatus.loading) {
      return;
    }
    currentPage += 1;
    status = DataLoadStatus.loading;
    final NetResponseData<List<T>> res = await loadData();
    if (res.success) {
      if (res.data != null && res.data is List<T> && res.data!.isNotEmpty) {
        dataList.addAll(res.data!);
        status = DataLoadStatus.succeed;
      } else {
        status = DataLoadStatus.empty;
      }
    } else {
      currentPage -= 1;
      status = DataLoadStatus.failed;
    }
    return;
  }

  void addItem(T value) {
    if (!dataList.contains(value)) {
      dataList.add(value);
      reloadData();
    }
  }

  void addAll(List<T> list) {
    if (list.isNotEmpty) {
      dataList.addAll(list);
      reloadData();
    }
  }

  void insertItemAtIndex({required T value, required int index}) {
    if (index < dataList.length) {
      dataList.insert(index, value);
      reloadData();
    }
  }

  void deleteItem(T value) {
    if (dataList.contains(value)) {
      dataList.remove(value);
      reloadData();
    }
  }

  void deleteItemAtIndex(int index) {
    if (index < dataList.length) {
      dataList.removeAt(index);
      reloadData();
    }
  }

  @protected
  void reloadData() {
    if (hasListeners) {
      notifyListeners();
    }
  }

  @protected
  Future<NetResponseData<List<T>>> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }
}

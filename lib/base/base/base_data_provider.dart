import 'package:flutter/cupertino.dart';
import 'package:hz_tools/hz_tools.dart';

import 'data_load_status.dart';
import 'net_response_data.dart';

class BaseDataProvider<T> with ChangeNotifier {
  T? model;
  DataLoadStatus _status = DataLoadStatus.initial;
  set status(DataLoadStatus value) {
    _status = value;
    reloadData();
  }

  DataLoadStatus get status => _status;

  bool get isLoading => _status == DataLoadStatus.loading;
  bool get isFailed => _status == DataLoadStatus.failed;
  bool get isEmpty => _status == DataLoadStatus.empty;

  Future<dynamic> startLoadData() async {
    if (isLoading) {
      return;
    }
    status = DataLoadStatus.loading;
    HzLog.t('$runtimeType startLoadData status:$status');
    final NetResponseData<T> response = await loadData();
    HzLog.t('$runtimeType startLoadData response:$response');
    if (response.success) {
      if (response.data != null && response.data is T) {
        model = response.data;
        status = DataLoadStatus.succeed;
      } else {
        status = DataLoadStatus.empty;
      }
    } else {
      status = DataLoadStatus.failed;
    }
  }

  void reloadData() {
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future<NetResponseData<T>> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }
}

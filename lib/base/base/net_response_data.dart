import 'package:http_plugin/http/response_data.dart';

typedef FromJsonFunc<T> = T Function(ResponseDataType);

class NetResponseData<T> {
  NetResponseData({
    this.fromJson,
    this.code,
    this.message,
    this.success = false,
    this.data,
  });

  NetResponseData.fromResponseDataType(ResponseDataType dataType, this.fromJson)
      : success = dataType.success,
        code = dataType.code,
        message = dataType.message {
    data = fromJson?.call(dataType);
  }
  final FromJsonFunc<T>? fromJson;
  final String? code;
  final String? message;
  final bool success;
  T? data;

  NetResponseData<T> copyWith({String? code, String? message, bool? success, T? data}) {
    return NetResponseData<T>(code: code, message: message, success: success ?? false, data: data);
  }
}

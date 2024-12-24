
import 'package:weather_app/app/data/data_source/network/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  int? statusCode;

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.initial() : status = Status.INITIAL;
  ApiResponse.completed(this.data, [this.statusCode]) : status = Status.COMPLETED;
  ApiResponse.error(this.message, [this.statusCode]) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \nMessage : $message \nData : $data";
  }
}


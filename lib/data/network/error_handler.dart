import 'package:dio/dio.dart';
import 'package:mvvmproject/data/network/faliure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCELLED,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  UNKNOWN,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //dio error so its error from api
      failure = _handleError(error);
    } else if (error is DataSource) {
      failure = error.getFailure();
    } else {
      failure = DataSource.UNKNOWN.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.cancel:
        return DataSource.CANCELLED.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.SUCCESS:
            return DataSource.SUCCESS.getFailure();
          case ResponseCode.NO_CONTENT:
            return DataSource.NO_CONTENT.getFailure();
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.UNKNOWN.getFailure();
        }
      case DioErrorType.other:
        return DataSource.UNKNOWN.getFailure();
      default:
        return DataSource.UNKNOWN.getFailure();
    }
  }
}

class ResponseCode {
//api status code
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400; //api rejected the request
  static const int FORBIDDEN = 403; //api rejected the request
  static const int UNAUTHORIZED = 401; //user is not authorized
  static const int NOT_FOUND = 404; //api not found
  static const int INTERNAL_SERVER_ERROR = 500; //server error

//local status code
  static const int UNKNOWN = -1;
  static const int CONNECT_TIMEOUT = -2; //
  static const int CANCELLED = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(
            code: ResponseCode.BAD_REQUEST,
            message: ResponsesMessages.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(
            code: ResponseCode.FORBIDDEN, message: ResponsesMessages.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(
            code: ResponseCode.UNAUTHORIZED,
            message: ResponsesMessages.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(
            code: ResponseCode.NOT_FOUND, message: ResponsesMessages.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponsesMessages.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            code: ResponseCode.CONNECT_TIMEOUT,
            message: ResponsesMessages.CONNECT_TIMEOUT);
      case DataSource.CANCELLED:
        return Failure(
            code: ResponseCode.CANCELLED, message: ResponsesMessages.CANCELLED);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            code: ResponseCode.RECEIVE_TIMEOUT,
            message: ResponsesMessages.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponsesMessages.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(
            code: ResponseCode.CACHE_ERROR,
            message: ResponsesMessages.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
            code: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponsesMessages.NO_INTERNET_CONNECTION);
      case DataSource.UNKNOWN:
        return Failure(
            code: ResponseCode.UNKNOWN, message: ResponsesMessages.UNKNOWN);
      default:
        return Failure(
            code: ResponseCode.UNKNOWN, message: ResponsesMessages.UNKNOWN);
    }
  }
}

class ResponsesMessages {
  static const String SUCCESS = 'Success';
  static const String NO_CONTENT = 'Success with No Content';
  static const String BAD_REQUEST = 'Bad Request, try again later';
  static const String FORBIDDEN = 'Forbidden, try again later';
  static const String UNAUTHORIZED = 'Unauthorized user';
  static const String NOT_FOUND = 'URL Not Found';
  static const String INTERNAL_SERVER_ERROR = 'Internal Server Error';
  static const String UNKNOWN = 'Something went wrong, try again later';
  static const String CONNECT_TIMEOUT = 'Connection Timeout';
  static const String CANCELLED = 'Request was Cancelled';
  static const String RECEIVE_TIMEOUT = 'Receive Timeout, try again later';
  static const String SEND_TIMEOUT = 'Send Timeout, try again later';
  static const String CACHE_ERROR = 'Cache Error, try again later';
  static const String NO_INTERNET_CONNECTION =
      'No Internet Connection, Please check your internet connection';
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
  static const int ERROR = 2;
  static const int WARNING = 3;
  static const int INFO = 4;
  static const int NO_INTERNET_CONNECTION = 5;
  static const int UNKNOWN = 6;
}

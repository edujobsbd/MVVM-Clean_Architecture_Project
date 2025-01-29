import 'package:mvvmproject/data/network/error_handler.dart';

class Failure {
  int code;//error code 
  String message;//error message
  Failure({required this.code, required this.message});
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(code: ResponseCode.UNKNOWN, message: ResponsesMessages.UNKNOWN);
}
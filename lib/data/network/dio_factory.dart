import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvmproject/app/app_prefs.dart';
import 'package:mvvmproject/app/constant.dart';
import 'package:mvvmproject/presentation/resources/language_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = 'application/json';
const String ACCEPT = 'Accept';
const String CONTENT_TYPE = 'Content-Type';
const String AUTHORIZATION = 'Authorization';
const String DEFAULT_LANGUAGE = 'language';


class DioFactory {

  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> gerDio() async {
    Dio dio = Dio();

    int _timeOut = 60*1000;
    String language = await _appPreferences.getLanguage();


     Map<String, String> headers = {
      ACCEPT: APPLICATION_JSON,
      CONTENT_TYPE: APPLICATION_JSON,
      DEFAULT_LANGUAGE: language,
      AUTHORIZATION:Constant.token
      };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers,);

    if(kReleaseMode){
      print('Release Mode no log');
    }else{
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
     return dio;

  }
}
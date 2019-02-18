import 'package:dio/dio.dart';
import 'package:mdb/src/utils/constants.dart';

AppModule _appModule;

AppModule get appModule {
  if (_appModule == null) {
    _appModule = AppModule.internal();
  }
  return
    _appModule;
}

class AppModule {
  AppModule.internal();

  Dio _dio;

  Dio get dio {
    if (_dio == null) {
      _dio = Dio();
      _dio.interceptors.add(_apiKeyInterceptor);
      _dio.interceptors.add(_baseUrlInterceptor);
      _dio.interceptors.add(_logInterceptor);
    }
    return _dio;
  }

  Interceptor get _apiKeyInterceptor =>
      InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
        requestOptions.queryParameters.addAll({apiKey: theMovieDBApiKey});
      });

  Interceptor get _baseUrlInterceptor =>
      InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
        requestOptions.baseUrl = baseUrl;
      });

  Interceptor get _logInterceptor =>
      LogInterceptor(request: true,
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false);

}
import 'package:dio/dio.dart';
import 'package:maps_app/services/traffic_interceptor.dart';


class PlacesInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

     options.queryParameters.addAll(
      {
        'country': 'cl',
        'language': 'es',
        'access_token': accessToken,
        'limit': 7
      });

    super.onRequest(options, handler);
  }

}
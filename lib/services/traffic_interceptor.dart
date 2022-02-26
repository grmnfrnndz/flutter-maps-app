

import 'package:dio/dio.dart';

const accessToken = 'pk.eyJ1IjoiZ2VybWFuZGV2b3BzIiwiYSI6ImNsMDQwN3V2ZDFqNWszaGxzMjFveXMxMWkifQ.9ykWyp0zKVf8jjsgeA-NpA';


class TrafficInterceptor extends Interceptor{

@override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll(
      {
        'alternatives': true,
        'geometries': 'polyline6',
        'overview': 'simplified',
        'steps': false,
        'access_token': accessToken
      });

    super.onRequest(options, handler);
  }

}
import 'package:dio/dio.dart';

import '../entity/http_response.dart';
import '../enum/request_type.dart';

abstract class IHttpClient {
  Future<HttpResponse> request({
    required RequestType type,
    required String path,
    Object? data,
    Options? options,
    String? savePath,
  });
}

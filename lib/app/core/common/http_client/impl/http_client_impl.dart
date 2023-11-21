import 'package:dio/dio.dart';

import '../../error/exceptions.dart';
import '../entity/http_response.dart';
import '../enum/request_type.dart';
import '../i_http/i_http_client.dart';

class HttpClientImpl implements IHttpClient {
  final Dio dioClient;

  HttpClientImpl(this.dioClient);

  @override
  Future<HttpResponse> request(
      {required RequestType type,
      required String path,
      Object? data,
      Options? options,
      String? savePath}) async {
    switch (type) {
      case RequestType.GET:
        final response = await dioClient.get(
          path,
          data: data,
          options: options,
        );
        return HttpResponse(
            statusCode: response.statusCode, data: response.data);

      case RequestType.POST:
        final response = await dioClient.post(
          path,
          data: data,
          options: options,
        );
        return HttpResponse(
            statusCode: response.statusCode, data: response.data);
      case RequestType.DOWNLOAD:
        final response = await dioClient.download(path, savePath);
        return HttpResponse(
            statusCode: response.statusCode, data: response.data);
      default:
        throw const ServerException('Select a request type');
    }
  }
}

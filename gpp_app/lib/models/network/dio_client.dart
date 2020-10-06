import 'package:dio/dio.dart';

class DioClient {
  // for url
  static String server_url = 'http://localhost:5000/';
  // String server = 'http://3.34.105.15:5000/';
  // String server = 'https://3.34.105.15:5000/';
  // String server = 'https://dev.goodpp.ai';

  // dio instance
  final Dio _dio;

  // injecting dio instance
  // :Ex: final DioClient dioClient = DioClient(Dio());
  DioClient(this._dio);

  // Get
  // :Return: Future<dynamic>, so in use then() to print return value
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }

  // Post
  // :Return: Future<dynamic>, so in use then() to print return value
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
}

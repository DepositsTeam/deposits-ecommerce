import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'logging.dart';

enum Method { POST, GET, PUT, DELETE, PATCH, FORM }

class DioClient {
  Future<dynamic> request(
      {required BuildContext context,
      required String api,
      required Method method,
      Map<String, dynamic>? params,
      dynamic payloadObj}) async {
    Dio _dio = Dio();
    _dio = Dio(BaseOptions(
      baseUrl: await Constants.baseUrl(),
    ))
      ..interceptors.add(Logging());
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    var response;
    var payload = json.encode(payloadObj);
    try {
      if (method == Method.POST) {
        response = await _dio
            .post(api, queryParameters: params);
  
      } else if (method == Method.FORM) {
        response =
            await _dio.post(api, data: payload);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(api);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(api);
      } else {
        response = await _dio
            .get(api, queryParameters: params);
      }
     
      return response.data;
    } on DioError catch (e) {
      return Utils.showSnackbar(context, Strings.error,
          Utils.handleErrorComing(e).toTitleCase(), Colors.red);
    }
  }
}

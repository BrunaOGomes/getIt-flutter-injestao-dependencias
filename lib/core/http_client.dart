import 'package:dio/dio.dart';

class CustomHttpClient {
  final Dio dio;
  final String baseUrl;

  // Inicializa o client Dio com baseUrl customizado
  CustomHttpClient({this.baseUrl = 'https://gdapp.com.br/api/fiap'})
    : dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Método genérico para GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  // Método genérico para POST
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post(path, data: data, queryParameters: queryParameters);
  }

  // Método genérico para DELETE
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.delete(path, queryParameters: queryParameters);
  }

  // Método genérico para PUT
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.put(path, data: data, queryParameters: queryParameters);
  }
}

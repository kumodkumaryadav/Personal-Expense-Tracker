import 'dart:io';

import 'package:dio/dio.dart';
import 'package:personal_expense_tracker/respurces/api_helper.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiHepler.baseUrl));
  ApiService() {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<T> get<T>(
    String endPoint, {
    Map<String, dynamic>? queryParameter,
    Map<String, dynamic>? headers,
  }) async {
    return _callApi<T>('GET', endPoint,
        queryParameter: queryParameter, headers: headers);
  }

  Future<T> post<T>(String endPoint,
      {Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers}) async {
    return _callApi("POST", endPoint,
        data: data, queryParameter: queryParameter, headers: headers);
  }

  Future<T> _callApi<T>(String method, String endpoint,
      {dynamic data,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      switch (method) {
        case "GET":
          response = await dio.get(endpoint,
              queryParameters: queryParameter,
              options: Options(headers: headers));
          break;
        case "POST":
          response = await dio.post(endpoint,
              queryParameters: queryParameter,
              options: Options(headers: headers),
              data: data);
          break;
        default:
          throw Exception("UnSupported http method: $method");
      }
      return response.data as T;
    } on DioError catch (e) {
      if (e.response != null) {
        final int? statusCode = e.response!.statusCode;
        if (statusCode == 401) {
        } else if (statusCode == 403) {}
      }
      throw CustomDioExceptions.fromDioException(e);
    }
  }
}
class CustomDioExceptions implements Exception {
  final int? statusCode;
  final String? message;
  
  CustomDioExceptions({required this.statusCode, required this.message});

  factory CustomDioExceptions.fromDioException(DioError dioError) {
    String tempMessage = "Unexpected error occurred";
    int? tempStatusCode;
    
    if (dioError.response != null) {
      tempStatusCode = dioError.response!.statusCode;
      tempMessage = dioError.response!.data['status'] ?? "";
      if(tempMessage.isEmpty) {
        tempMessage = dioError.response!.data['error'] ?? "";
      }
    } else if (dioError.error is SocketException) {
      tempMessage = "No internet connection";
    }
    
    return CustomDioExceptions(
      statusCode: tempStatusCode, 
      message: tempMessage
    );
  }
}


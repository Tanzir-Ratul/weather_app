import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../utils/constant.dart';
import '../../local/preferences/shared_preference.dart';
import 'base_api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClientService extends BaseApiServices {
  final Dio _dio;
  final SecureStorageService _secureStorageService = SecureStorageService();

  HttpClientService(this._dio) {
    _initApiClient();
  }

  void _initApiClient() {

     final getBaseUrl = dotenv.env['APP_BASE_URL'] ?? "";//do not change key name, cause it is saved in .env at root directory file for not getting the base url by reverse engineering
     _dio.options.baseUrl = getBaseUrl;
    _dio.options.connectTimeout =  const Duration(milliseconds: 30000);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);

// Add the Dio logger interceptor
    //_dio.interceptors.add(dioLoggerInterceptor);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await _secureStorageService.read(Constant.token);
          if (!options.headers.containsKey("Authorization") && token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          options.headers["Accept"] = "application/json";
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (e, handler) {
          if (e.response != null) {
            // Handle the error when a response is available
            return handler.next(e);
          } else {
            // Handle other errors (e.g., network errors)
            throw Exception(e.message);
          }
        },
      ),
    );
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool authorization = false,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      debugPrint("Headers ${headers.toString()}");
      debugPrint("Response ${response.data}");
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? headers,
    @required body,
    authorization = false,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    }  on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> post(String url,
      {Map<String, dynamic>? headers,
      @required body,
      authorization = false}) async {
    try {
      debugPrint('urlFromPost $url');
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      // Log the DioException details
      debugPrint('DioException Type: ${e.type}');
      debugPrint('DioException Message: ${e.message}');
      debugPrint('DioException Response Data: ${e.response?.data}');
      debugPrint('DioException Request Data: ${e.requestOptions.data}');
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? headers,
    @required body,
    authorization = false,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        return e.response!.data;
      } else {
        throw Exception(e.message);
      }
    }
  }
}

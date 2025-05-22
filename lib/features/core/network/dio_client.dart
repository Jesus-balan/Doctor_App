import 'package:dio/dio.dart';
import 'package:frontend/features/core/network/api_constant.dart';
import 'package:frontend/features/core/service/hive_service.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await HiveService().getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          final is401 = e.response?.statusCode == 401;
          final isRetry = e.requestOptions.extra['retry'] == true;

          if (is401 && !isRetry) {
            final refreshToken = await HiveService().getRefreshToken();
            if (refreshToken != null) {
              try {
                final refreshDio = Dio(
                  BaseOptions(
                    baseUrl: ApiConstants.baseUrl,
                    headers: {'Content-Type': 'application/json'},
                  ),
                );
                final refreshResponse = await refreshDio.post(
                  ApiConstants.refreshToken,
                  data: {"refresh": refreshToken},
                );

                final newAccessToken = refreshResponse.data['access'];
                await HiveService().saveToken(newAccessToken);

                // Retry the original request with new token
                final RequestOptions requestOptions = e.requestOptions;
                requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                requestOptions.extra['retry'] = true; // prevent loop
                final newResponse = await _dio.fetch(requestOptions);
                return handler.resolve(newResponse);
              } catch (refreshError) {
                await HiveService().logout();
                return handler.reject(DioError(
                  requestOptions: e.requestOptions,
                  error: "Refresh token expired",
                  type: DioErrorType.badResponse,
                  response: e.response,
                ));
              }
            }
          }

          return handler.next(e);
        },
      ),
    );

  static Dio get client => _dio;
}

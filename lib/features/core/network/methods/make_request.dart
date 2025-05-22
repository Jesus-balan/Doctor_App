import 'dart:convert';
import 'package:frontend/features/core/network/api_constant.dart';
import 'package:frontend/features/core/service/hive_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HttpService {
  static final String baseUrl = ApiConstants.baseUrl;

  static Future<http.Response> makeAuthenticatedRequest(
    Uri url, {
    required String method,
    Map<String, String>? headers,
    Object? body,
    Duration timeout = const Duration(seconds: 10),
    BuildContext? context, // Add context for navigation
  }) async {
    final hive = HiveService();
    String? token = await hive.getToken();

    headers ??= {};
    headers['Authorization'] = 'Bearer $token';
    headers['Content-Type'] = 'application/json';

    http.Response response;
    print('token irukka : $token');
    try {
      switch (method) {
        case 'GET':
          response = await http.get(url, headers: headers);
          break;
        case 'POST':
          response = await http.post(url, headers: headers, body: body);
          break;
        case 'PATCH':
          response = await http.patch(url, headers: headers, body: body);
          break;
        case 'PUT':
          response = await http.put(url, headers: headers, body: body);
          break;
        case 'DELETE':
          response = await http.delete(url, headers: headers, body: body);
          break;
        default:
          throw Exception("Unsupported method: $method");
      }

      if (response.statusCode == 401) {
        final refreshToken = await hive.getRefreshToken();
        final refreshUrl = Uri.parse("${baseUrl}access/token/refresh/");
        final refreshResponse = await http.post(
          refreshUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"refresh": refreshToken}),
        );

        if (refreshResponse.statusCode == 200) {
          final newToken = jsonDecode(refreshResponse.body)['access'];
          await hive.saveToken(newToken);
          headers['Authorization'] = 'Bearer $newToken';

          // Retry original request
          switch (method) {
            case 'GET':
              response = await http.get(url, headers: headers);
              break;
            case 'POST':
              response = await http.post(url, headers: headers, body: body);
              break;
            case 'PATCH':
              response = await http.patch(url, headers: headers, body: body);
              break;
            case 'PUT':
              response = await http.put(url, headers: headers, body: body);
              break;
            case 'DELETE':
              response = await http.delete(url, headers: headers, body: body);
              break;
          }
        } else {
          // 🔴 Refresh token failed: Logout the user
          await hive.logout();

          if (context != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
          }

          throw Exception("Session expired. Please log in again.");
        }
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}

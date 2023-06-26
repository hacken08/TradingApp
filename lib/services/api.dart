import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/const.dart';

class ApiResponse {
  bool status;
  dynamic data;
  String message;

  ApiResponse({
    required this.status,
    required this.data,
    required this.message,
  });
}

Future<ApiResponse> apiCall({
  required String query,
  Map<String, dynamic>? variables,
  Map<String, String>? headers,
}) async {
  try {
    log(jsonEncode({
      'query': query,
      'variables': variables,
    }));
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json', // Set the Content-Type header
        // ...headers ?? {}, // Include additional headers if provided
      },
      body: jsonEncode({
        'query': query,
        'variables': variables,
      }),
    );

    final responseData = jsonDecode(response.body);
    log(variables.toString());

    if (responseData['data'] == null || responseData['data'] == '') {
      log("one");
      log(responseData.toString());
      if (responseData['errors'][0]['originalError'] == "" ||
          responseData['errors'][0]['originalError'] == null) {
        log("two");
        return ApiResponse(
          status: false,
          data: [],
          message: responseData['errors'][0]['message'],
        );
      }

      final errorMessage =
          responseData['errors'][0]['originalError']['message'];

      return ApiResponse(
        status: false,
        data: [],
        message: errorMessage is List ? errorMessage[0] : errorMessage,
      );
    }

    return ApiResponse(
      status: true,
      data: responseData['data'],
      message: '',
    );
  } catch (e) {
    return ApiResponse(
      status: false,
      data: [],
      message: e.toString(),
    );
  }
}

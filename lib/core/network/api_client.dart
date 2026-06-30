import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://shineup-backend-production.up.railway.app/api/v1';

  String? _token;
  String _languageCode = 'ar';

  void setToken(String? token) {
    _token = token;
  }

  void setLanguageCode(String code) {
    _languageCode = code;
  }

  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept-Language': _languageCode,
    };
    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<Map<String, dynamic>> get(String path) async {
    log('GET $path');
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    log('GET $path: ${response.statusCode} ${response.body}');
    return _handleResponse(response);
  }

  Future<List<dynamic>> getList(String path) async {
    log('GET $path');
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    log('GET $path: ${response.statusCode} ${response.body}');
    return _handleListResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    log('POST $path: ${body != null ? jsonEncode(body) : 'No body'}');
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    log('POST $path: ${response.statusCode} ${response.body}');
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    log('PATCH $path: ${body != null ? jsonEncode(body) : 'No body'}');
    final response = await http.patch(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    log('PATCH $path: ${response.statusCode} ${response.body}');
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String path) async {
    log('DELETE $path');
    final response = await http.delete(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    log('DELETE $path: ${response.statusCode} ${response.body}');
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> uploadFile(
    String path, {
    required String filePath,
    String fieldName = 'file',
    String method = 'POST',
  }) async {
    log('UPLOAD $path: $filePath');
    final request = http.MultipartRequest(
      method,
      Uri.parse('$baseUrl$path'),
    );
    request.headers.addAll(_headers);
    request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    log('UPLOAD $path: ${response.statusCode} ${response.body}');
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final data = response.body.isNotEmpty
        ? jsonDecode(response.body) as Map<String, dynamic>
        : <String, dynamic>{};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    final message =
        data['message'] as String? ?? 'Request failed (${response.statusCode})';
    throw ApiException(message, response.statusCode);
  }

  List<dynamic> _handleListResponse(http.Response response) {
    final data = response.body.isNotEmpty
        ? jsonDecode(response.body) as List<dynamic>
        : <dynamic>[];

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    final message = data.isNotEmpty && data.first is Map
        ? (data.first as Map<String, dynamic>)['message'] as String?
        : 'Request failed (${response.statusCode})';
    throw ApiException(message ?? 'Request failed (${response.statusCode})', response.statusCode);
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}

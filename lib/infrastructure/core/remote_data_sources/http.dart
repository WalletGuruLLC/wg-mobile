import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart'; // Necesario para MediaType

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpDataSource {
  static final Map<String, String> _headers = {};

  static Future<void> setHeaders() async {
    _headers[HttpHeaders.contentTypeHeader] = 'application/json';
    final storage = await SharedPreferences.getInstance();
    final String? basic = storage.getString('Basic');
    if (basic != null) {
      _headers['Authorization'] = 'Bearer $basic';
    }
  }

  static void cleanHeaders() async {
    final storage = await SharedPreferences.getInstance();
    storage.remove('Basic');
    _headers.clear();
  }

  // Parses a JSON string into a Map
  // Returns: Map<String, dynamic>
  static dynamic decode(String response) => json.decode(response);

  // Encodes a Map into a JSON string
  // Returns: String
  static String encode(Map<String, dynamic> response) => json.encode(response);

  // Makes GET requests to the backend at the specified endpoint
  // Returns: Future with the result of the query
  static Future<dynamic> get(String path) async {
    await setHeaders();
    Uri uri = Uri.parse(path);
    try {
      final response = await http.get(uri, headers: _headers);
      return response;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Makes POST requests to the backend at the specified endpoint with data
  // Returns: Future with the result of the query
  static Future<dynamic> post(String path, Map<String, dynamic> data) async {
    await setHeaders();
    final body = encode(data);
    Uri uri = Uri.parse(path);
    try {
      final response = await http.post(uri, body: body, headers: _headers);
      return response;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Makes PATCH requests to the backend at the specified endpoint with data
  // Returns: Future with the result of the query
  static Future<dynamic> patch(String path, Map<String, dynamic> data) async {
    await setHeaders();
    final body = encode(data);
    Uri uri = Uri.parse(path);
    try {
      final response = await http.patch(uri, body: body, headers: _headers);
      return response;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Makes PUT requests to the backend at the specified endpoint with data
  // Returns: Future with the result of the query
  static Future<dynamic> put(String path, Map<String, dynamic> data) async {
    await setHeaders();
    final body = encode(data);
    Uri uri = Uri.parse(path);
    try {
      final response = await http.put(uri, body: body, headers: _headers);
      return response;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Makes DELETE requests to the backend at the specified endpoint with data
  // Returns: Future with the result of the query
  static Future<dynamic> delete(String path, Map<String, dynamic> data) async {
    final body = encode(data);
    Uri uri = Uri.parse(path);
    final response = await http.delete(uri, body: body, headers: _headers);
    return _processResponse(response);
  }

  static Future<dynamic> putMultipart(String path, File file) async {
    await setHeaders();
    String fieldName = 'file';
    String filePath = file.path;
    String mimeType = _getMimeType(filePath);

    Uri uri = Uri.parse(path);
    var request = http.MultipartRequest('PUT', uri);
    request.headers.addAll(_headers);

    request.files.add(
      await http.MultipartFile.fromPath(
        fieldName,
        filePath,
        contentType: MediaType.parse(mimeType),
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return response;
    } on Exception catch (e) {
      throw Exception('Error al subir el archivo: $e');
    }
  }

  // Processes the HTTP response and handles errors
  // Returns: Future with the decoded response body
  static dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return decode(response.body);
      case 201:
        return decode(response.body);
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
      case 403:
        throw Exception('Unauthorized: ${response.body}');
      case 500:
      default:
        throw Exception(response);
    }
  }

  static String _getMimeType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'pdf':
        return 'application/pdf';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream'; // Tipo MIME genérico
    }
  }
}

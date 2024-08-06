import 'package:http/http.dart';

class HttpDataSource {
  Future<Response> httpGet(
    String url, {
    String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return await get(Uri.parse(url), headers: headers);
  }

  Future<Response> httpPost(
    String url, {
    String? body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return await post(Uri.parse(url), headers: headers, body: body);
  }

  Future<Response> httpPut(
    String url, {
    required String body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return await put(Uri.parse(url), headers: headers, body: body);
  }

  Future<Response> httpDelete(
    String url, {
    String? body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return await delete(Uri.parse(url), headers: headers, body: body);
  }
}

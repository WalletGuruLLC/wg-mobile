import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_guru/infrastructure/core/env/env.dart';

class SumSubAPI {
  static String appToken = Env.sumSubApiToken;
  static String secretKey = Env.sumSubApiSecret;

  // Set the headers
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static Future<Map<String, String>> setSumSubHeaders(
      String path, String method, String body) async {
    final timestamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final signatureData = '$timestamp$method$path$body';

    // Generate HMAC signature
    final hmac = Hmac(sha256, utf8.encode(secretKey));
    final signature = hmac.convert(utf8.encode(signatureData)).toString();

    headers['X-App-Access-Ts'] = timestamp;
    headers['X-App-Access-Sig'] = signature;
    headers['X-App-Token'] = appToken;

    return headers;
  }

  // Post Request Method for SumSub API
  static Future<http.Response> postSumSub(
      String path, Map<String, dynamic> data) async {
    final uri = Uri.parse(path);
    final body = jsonEncode(data);

    final headers = await setSumSubHeaders(uri.path, 'POST', body);

    try {
      final response = await http.post(uri, body: body, headers: headers);
      return response;
    } catch (e) {
      throw Exception("Failed to send request: $e");
    }
  }

  // You can add more methods like uploadPhoto(), getApplicantStatus() using the same structure
}

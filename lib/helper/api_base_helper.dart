import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiBaseHelper {

  ApiBaseHelper();

  Future<dynamic> get(String url) async {
    return await http
        .get(Uri.parse(url))
        .then((res) => _handleResponse(res));
  }

  Future<dynamic> post(String url, dynamic data) async {
    return await http
        .post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(data),
        )
        .then((res) => _handleResponse(res));
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw Exception('Bad request');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Not found');
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('Received invalid status code: ${response.statusCode}');
    }
  }
}

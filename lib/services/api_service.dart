import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> httpGet(String path,
      {Map<String, String>? queryParams}) async {
    Uri uri = Uri.parse(path);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }
    try {
      var response = await http.get(uri);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> httpPost(String path, dynamic body) async {
    Uri uri = Uri.parse(path);
    try {
      var response = await http.post(uri, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

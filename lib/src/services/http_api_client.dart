import 'package:access_control/src/services/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class HttpApiClient implements ApiClient {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final String baseUrl;

  HttpApiClient(this.baseUrl);

  @override
  Future<http.Response> get(String endpoint) async {
    final Uri uri = Uri.parse('$baseUrl/$endpoint');
    String? authToken = await secureStorage.read(key: 'token');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    return response;
  }

  @override
  Future<http.Response> post(
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    String? authToken = await secureStorage.read(key: 'token');

    final Uri uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(
      uri,
      body: data,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    return response;
  }
}

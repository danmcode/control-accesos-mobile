import 'dart:convert';

import 'package:access_control/src/constants/constants.dart';
import 'package:access_control/src/services/http_api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? username = '';
  String? password = '';

  bool isValidForm() => formKey.currentState?.validate() ?? false;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String? username, String? password) async {
    String token = '';
    final HttpApiClient apiClient = HttpApiClient(ServerApi.serverDev);

    final response = await apiClient.post(
      'api/v1/auth',
      data: {'username': username, 'password': password},
    );

    dynamic jsonData = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        token = jsonData['data']['token'];

        await _secureStorage.write(key: 'token', value: token);
        notifyListeners();

        return {
          'status': jsonData['status'],
          'message': jsonData['message'],
        };
      } else {
        return {
          'status': jsonData['status'],
          'message': jsonData['message'],
          'error': jsonData['errors'],
        };
      }
    } catch (e) {
      return {
        'status': 504,
        'message': 'No se pudo conectar al servidor',
        'error': 'Error de conexión',
        'user': '',
      };
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'token');
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    String? storedToken = await _secureStorage.read(key: 'token');
    return storedToken != '';
  }

  bool isTokenExpired(String token) {
    return false;
  }
}

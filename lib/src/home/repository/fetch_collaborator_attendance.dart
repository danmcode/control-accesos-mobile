import 'dart:convert';
import 'package:access_control/src/constants/constants.dart';
import 'package:access_control/src/models/collaborators.dart';
import 'package:access_control/src/services/http_api_client.dart';

class FetchCollaboratorAttendance {
  static Future<Map<String, dynamic>> fetchData(
      {required String identification}) async {
    try {
      final HttpApiClient apiClient = HttpApiClient(ServerApi.serverDev);
      final response = await apiClient.post(
        'api/v1/collaborator/attendance',
        data: {'identification': identification},
      );

      dynamic jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        User user = User(
          id: jsonData['data']['user']['id'],
          username: jsonData['data']['user']['username'],
          identification: jsonData['data']['user']['identification'],
          identificationType: jsonData['data']['user']['identification_type'],
          photoPath: jsonData['data']['user']['photo_path'],
          name: jsonData['data']['user']['name'],
          lastName: jsonData['data']['user']['last_name'],
          isActive: jsonData['data']['user']['is_active'],
          email: jsonData['data']['user']['email'],
          roleId: jsonData['data']['user']['rol_id'],
          isColaborator: jsonData['data']['user']['is_colaborator'] ?? 0,
        );

        return {
          'status': jsonData['status'],
          'message': jsonData['message'],
          'user': '${user.name} ${user.lastName}',
        };
      } else {
        return {
          'status': jsonData['status'],
          'message': jsonData['message'],
          'error': jsonData['errors'],
          'user': '',
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
}

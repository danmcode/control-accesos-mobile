import 'dart:convert';
import 'package:access_control/src/constants/constants.dart';
import 'package:access_control/src/models/incomes.dart';
import 'package:access_control/src/services/http_api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/incomes_provider.dart';

class FetchIncomes {
  static Future<Map<String, dynamic>> fetchData(BuildContext context) async {
    final incomesProvider =
        Provider.of<IncomesProvider>(context, listen: false);

    List<Datum> incomes = [];
    try {
      final HttpApiClient apiClient = HttpApiClient(ServerApi.serverDev);
      final response = await apiClient.get(
        'api/v1/collaborator/attendance/by-day',
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (jsonData['count'] != 0) {
          incomes = (jsonData['data'] as List<dynamic>)
              .map((e) => Datum.fromJson(e))
              .toList();
        }
        incomesProvider.numberOfCollaborators = jsonData['count'];
        incomesProvider.incomesList = incomes;
        return {
          'status': jsonData['status'],
          'message': jsonData['message'],
          'incomeList': incomes,
        };
      } else {
        return {
          'status': jsonData['status'],
          'message': jsonData['message'],
          'error': jsonData['errors'],
          'IncomeList': [],
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

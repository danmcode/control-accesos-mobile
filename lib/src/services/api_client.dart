
import 'package:http/http.dart';

abstract class ApiClient{
  Future<Response> get(String endpoint);
  Future<Response> post(String endpoint, {required Map<String, dynamic> data});
}
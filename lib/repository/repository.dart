import 'package:chisla_and_facts/api_client/api_client.dart';

class Repository {
  final ApiClient _apiClient = ApiClient();

  Future<String> getInfo (String number) async {
    return await _apiClient.getInfo(number);
  }
}
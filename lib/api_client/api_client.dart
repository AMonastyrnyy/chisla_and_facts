import 'package:http/http.dart';

class ApiClient {
  static const _baseUrl = 'numbersapi.com';
  final Client _httpClient = Client();

  Future<String> getInfo (String number) async {
    final request = Uri.http(
      _baseUrl,
      '$number/trivia',
    );
    final response = await _httpClient.get(request);
    return response.body;
  }
}
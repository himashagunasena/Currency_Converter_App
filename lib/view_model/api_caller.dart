import 'package:dio/dio.dart';

import '../model/currency_model.dart';

class ApiCaller {
  static const String baseUrl = 'https://api.exchangerate-api.com/v4/latest/';
  final Dio _dio = Dio();

  Future<CurrencyModel> fetchCurrencies(String baseCurrency) async {
    final url = '$baseUrl$baseCurrency';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        return CurrencyModel.fromJson(data);
      } else {
        throw Exception('Failed to load currencies: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Response Error: ${e.message}');
    }
  }
}

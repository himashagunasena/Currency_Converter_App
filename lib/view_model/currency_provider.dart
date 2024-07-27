import 'package:currency_converter_app/model/currency_model.dart';
import 'package:flutter/foundation.dart';
import 'api_caller.dart';

class CurrencyProvider extends ChangeNotifier {
  final ApiCaller _currencyApiCaller = ApiCaller();
  CurrencyModel? _currencies;
  bool _isLoading = true;
  String? _errorMessage;

  CurrencyModel? get currencies => _currencies;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchCurrencies(String baseCurrency) async {
    try {
      final currencies = await _currencyApiCaller.fetchCurrencies(baseCurrency);
      _currencies = currencies;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  String? updateConversion(
      String convertCurrency, String fromCurrencyCode, String toCurrencyCode) {
    final amount = double.tryParse(convertCurrency);
    if (amount != null) {
      if (isLoading) {
        return 'Loading...';
      }
      try {
        final fromRate = _currencies?.rates?[fromCurrencyCode];
        final toRate = _currencies?.rates?[toCurrencyCode];

        if (fromRate != null && toRate != null) {
          final convertedAmount = amount * (toRate / fromRate);
          return double.parse(convertedAmount.toStringAsFixed(4))
              .toStringAsFixed(2);
        } else {
          return 'Error: Invalid currency codes';
        }
      } catch (e) {
        return 'Error: ${e.toString()}';
      }
    } else {
      return '';
    }
  }
}

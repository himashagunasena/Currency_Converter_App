import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter_app/view/widget/common_textfield.dart';
import 'package:currency_converter_app/view/widget/country_list.dart';
import '../view_model/currency_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController currencyController = TextEditingController();
  String fromCurrencyCode = 'LKR';
  List<ConversionField> conversionFields = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currencyProvider =
          Provider.of<CurrencyProvider>(context, listen: false);
      currencyProvider.fetchCurrencies(fromCurrencyCode);
    });
    currencyController.addListener(_updateConversions);
    _addConversionField();
  }

  @override
  void dispose() {
    currencyController.dispose();
    for (var field in conversionFields) {
      field.convertCurrencyController.dispose();
    }
    super.dispose();
  }

  void _addConversionField() {
    setState(() {
      conversionFields.add(
        ConversionField(
          convertCurrencyController: TextEditingController(),
          toCurrencyCode: 'USD',
        ),
      );
      _updateConversions();
    });
  }

  void _removeConversionField(int index) {
    setState(() {
      conversionFields[index].convertCurrencyController.dispose();
      conversionFields.removeAt(index);
      _updateConversions();
    });
  }

  void _updateConversions() {
    setState(() {
      final currencyProvider =
          Provider.of<CurrencyProvider>(context, listen: false);
      for (var field in conversionFields) {
        final convertedAmount = currencyProvider.updateConversion(
          currencyController.text,
          fromCurrencyCode,
          field.toCurrencyCode,
        );
        field.convertCurrencyController.text = convertedAmount ?? 'Error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final colorTheme = Theme.of(context).colorScheme;
    final buttonStyle = Theme.of(context).filledButtonTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Advanced Exchanger",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        )),
        backgroundColor: colorTheme.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonTextField(
                textEditingController: currencyController,
                formatData: const [],
                placeHolder: "INSERT AMOUNT:",
                onChanged: (value) {
                  _updateConversions();
                },
                suffix: CountryList(
                  onCurrencyCodeChanged: (value) {
                    setState(() {
                      fromCurrencyCode = value;
                      currencyProvider
                          .fetchCurrencies(fromCurrencyCode)
                          .then((_) {
                        _updateConversions();
                      });
                    });
                  },
                  selectedCountry: fromCurrencyCode,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "CONVERT TO:",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                textAlign: TextAlign.left,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: conversionFields.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(conversionFields[index].toCurrencyCode),
                    onDismissed: (direction) {
                      _removeConversionField(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CommonTextField(
                        readOnly: true,
                        textEditingController:
                            conversionFields[index].convertCurrencyController,
                        formatData: const [],
                        suffix: CountryList(
                          onCurrencyCodeChanged: (value) {
                            setState(() {
                              conversionFields[index].toCurrencyCode = value;
                              currencyProvider.fetchCurrencies(value).then((_) {
                                _updateConversions();
                              });
                            });
                          },
                          selectedCountry:
                              conversionFields[index].toCurrencyCode,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: FilledButton(
                  onPressed: _addConversionField,
                  style: buttonStyle.style,
                  child: const Text("+ ADD CONVERTER"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConversionField {
  TextEditingController convertCurrencyController;
  String toCurrencyCode;

  ConversionField({
    required this.convertCurrencyController,
    required this.toCurrencyCode,
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import '../../view_model/currency_provider.dart';

class CountryList extends StatefulWidget {
  final ValueChanged<String> onCurrencyCodeChanged;
  final String? selectedCountry;

  const CountryList(
      {super.key, required this.onCurrencyCodeChanged, this.selectedCountry});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  String? selectedCurrencyCode = "";
  String newSelectedCode = "";

  @override
  void initState() {
    selectedCurrencyCode = widget.selectedCountry;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, provider, child) {
        return CountryPickerDropdown(
          initialValue:
              CountryPickerUtils.getCountryByCurrencyCode(selectedCurrencyCode!)
                  .isoCode,
          itemBuilder: _buildDropdownItem,
          onValuePicked: (Country? country) {
            if (country != null) {
              setState(() {
                selectedCurrencyCode = country.currencyCode!;
                widget.onCurrencyCodeChanged(
                    selectedCurrencyCode ?? newSelectedCode);
              });
            }
          },
        );
      },
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(Country country) =>
      DropdownMenuItem(
        value: country.currencyCode,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 20,
                width: 20,
                child: ClipOval(
                    child: CountryPickerUtils.getDefaultFlagImage(country))),
            const SizedBox(width: 8.0),
            Text(country.currencyCode ?? "USD"),
          ],
        ),
      );
}

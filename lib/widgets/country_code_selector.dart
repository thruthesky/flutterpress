import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryCodeSelector extends StatelessWidget {
  final bool withBorder;
  final Function onChanged;
  final String initialSelection;
  final bool enabled;

  CountryCodeSelector({
    this.withBorder = true,
    this.enabled,
    this.onChanged(CountryCode code),
    this.initialSelection = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      width: double.infinity,
      child: CountryCodePicker( 
        enabled: enabled,
        flagWidth: 50,
        textStyle: TextStyle(fontSize: 30),
        onChanged: onChanged,
        initialSelection: initialSelection,
        showCountryOnly: false,
        showOnlyCountryWhenClosed: false,
      ),
      decoration: withBorder
          ? BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              color: Colors.grey[300]
            )
          : null,
    );
  }
}

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CountryCodeSelector extends StatelessWidget {
  final bool withBorder;
  final Function onChanged;
  final String initialSelection;
  final bool enabled;

  CountryCodeSelector({
    this.withBorder = true,
    this.enabled = true,
    this.onChanged(CountryCode code),
    this.initialSelection = '',
  });

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      builder: (_) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: sm, horizontal: xs),
          width: double.infinity,
          child: Row(
            children: [
              Text(
                _.name + ' ' + '(${_.dialCode})',
                style: TextStyle(fontSize: lg),
              ),
              Spacer(),
              Icon(FontAwesomeIcons.ellipsisV, size: lg),
            ],
          ),
          decoration: withBorder
              ? BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                )
              : null,
        );
      },
      enabled: enabled,
      flagWidth: 50,
      textStyle: TextStyle(fontSize: 30),
      onChanged: onChanged,
      initialSelection: initialSelection,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
    );
  }
}

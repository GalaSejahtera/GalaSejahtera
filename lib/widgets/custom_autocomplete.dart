import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gala_sejahtera/utils/constants.dart';

class CustomAutocomplete extends StatelessWidget {
  final Function onChanged;
  final String hintText;
  final List<String> suggestions;
  final TextEditingController typeAheadController;

  const CustomAutocomplete(
      {this.onChanged,
      this.hintText,
      this.suggestions,
      this.typeAheadController});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(10.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: typeAheadController,
            autofocus: false,
            style: DefaultTextStyle.of(context).style,
            decoration: kTextFieldDecoration.copyWith(hintText: hintText)),
        suggestionsCallback: (pattern) async {
          if (suggestions != null) {
            return suggestions.where((element) =>
                element.toLowerCase().contains(pattern.toLowerCase()));
          } else
            return [];
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (suggestion) {
          onChanged(suggestion);
        },
      ),
    );
  }
}

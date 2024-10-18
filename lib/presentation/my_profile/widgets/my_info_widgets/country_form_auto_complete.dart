import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryFormAutoComplete extends StatefulWidget {
  final String? initialValue;
  final void Function(String?) onChanged;
  final Widget? fieldActivatorWidget;
  final bool? readOnly; //

  const CountryFormAutoComplete({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.fieldActivatorWidget,
    this.readOnly,
  });

  @override
  State<CountryFormAutoComplete> createState() =>
      _CountryFormAutoCompleteState();
}

class _CountryFormAutoCompleteState extends State<CountryFormAutoComplete> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);

        final createProfileCubit = context.read<CreateProfileCubit>();
        List<String> countries = List.from(state.countries);

        if (countries.contains('United States')) {
          countries.remove('United States');
          countries.insert(0, 'United States');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Autocomplete<String>(
              initialValue: TextEditingValue(text: widget.initialValue ?? ''),
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return countries.where((country) {
                  return country
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String value) {
                setState(() {
                  _isValid = true;
                });
                widget.onChanged(value);
                createProfileCubit.selectCountry(value);
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                _textEditingController = textEditingController;
                _focusNode = focusNode;
                return TextFormField(
                  readOnly: widget.readOnly ?? true,
                  controller: textEditingController,
                  focusNode: focusNode,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                  ),
                  decoration: CustomInputDecoration(
                    suffixIcon: widget.fieldActivatorWidget,
                    hintText: l10n!.country,
                  ).decoration,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                    _validateSelection(countries);
                  },
                  validator: (value) {
                    print('value: $value');
                    if (value == null ||
                        value.isEmpty ||
                        !countries.contains(value)) {
                      _isValid = false;
                      return l10n.pleaseSelectGenericValue;
                    }
                    _isValid = true;
                    return null;
                  },
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 45,
                      color: Color.fromARGB(255, 60, 59, 59),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(
                                option,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _validateSelection(List<String> validCountries) {
    setState(() {
      if (_textEditingController.text.isNotEmpty &&
          !validCountries.contains(_textEditingController.text)) {
        _isValid = false;
      } else {
        _isValid = true;
      }
    });
  }
}

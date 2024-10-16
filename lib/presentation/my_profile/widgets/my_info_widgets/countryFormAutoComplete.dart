import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class CountryFormAutocomplete extends StatefulWidget {
  final String? initialValue;
  final void Function(String?) onChanged;
  final Widget? fieldActivatorWidget;

  const CountryFormAutocomplete({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.fieldActivatorWidget,
  });

  @override
  _CountryFormAutocompleteState createState() =>
      _CountryFormAutocompleteState();
}

class _CountryFormAutocompleteState extends State<CountryFormAutocomplete> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool _isValid = true; // Estado para mostrar error si es necesario

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
                  _isValid = true; // Restablecer validez al seleccionar
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
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: CustomInputDecoration(
                    hintText: 'Country',
                  ).decoration,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                    _validateSelection(countries);
                  },
                  validator: (value) {
                    return _isValid ? null : 'Please select a valid country';
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
                      // Padding del 10% de la pantalla (aproximado)
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: const Color.fromARGB(255, 126, 122, 122),
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
      if (!_textEditingController.text.isEmpty &&
          !validCountries.contains(_textEditingController.text)) {
        _isValid = false; // Mostrar error si el valor no es válido
      } else {
        _isValid = true; // No mostrar error si el valor es válido
      }
    });
  }
}

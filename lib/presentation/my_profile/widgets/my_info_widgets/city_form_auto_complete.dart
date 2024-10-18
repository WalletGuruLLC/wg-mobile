import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CityFormAutocomplete extends StatefulWidget {
  final String? initialValue;
  final void Function(String?) onChanged;
  final Widget? fieldActivatorWidget;
  final bool? readOnly; // Estado para controlar si es de solo lectura

  const CityFormAutocomplete({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.fieldActivatorWidget,
    this.readOnly,
  });

  @override
  State<CityFormAutocomplete> createState() => _CityFormAutocompleteState();
}

class _CityFormAutocompleteState extends State<CityFormAutocomplete> {
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
    final userCity = BlocProvider.of<UserCubit>(context).state.user!.city;

    final l10n = AppLocalizations.of(context)!;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.user?.city == '') {
          _textEditingController.text = '';
        }
      },
      child: BlocBuilder<CreateProfileCubit, CreateProfileState>(
        builder: (context, state) {
          List<String> cities = List.from(state.cities);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Autocomplete<String>(
                initialValue: TextEditingValue(text: widget.initialValue ?? ''),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return cities.where((country) {
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
                    readOnly: widget.readOnly ??
                        true, // Controla la edición según el estado de readOnly
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                    ),
                    decoration: CustomInputDecoration(
                      hintText: l10n.city,
                      suffixIcon: widget.fieldActivatorWidget,
                    ).decoration,
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                      _validateSelection(cities);
                    },
                    validator: (value) {
                      if (userCity.isNotEmpty) {
                        return null;
                      }
                      print('value: $value');
                      if (value == null ||
                          value.isEmpty ||
                          cities.contains(value)) {
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
                        color: const Color.fromARGB(255, 60, 59, 59),
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
      ),
    );
  }

  void _validateSelection(List<String> cities) {
    setState(() {
      _isValid = cities.contains(_textEditingController.text);
    });
  }
}

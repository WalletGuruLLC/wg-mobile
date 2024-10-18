import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StateFormAutoComplete extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final Widget? fieldActivatorWidget;
  final bool? readOnly;

  const StateFormAutoComplete({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.fieldActivatorWidget,
    this.readOnly,
  });

  @override
  _StateFormAutoCompleteState createState() => _StateFormAutoCompleteState();
}

class _StateFormAutoCompleteState extends State<StateFormAutoComplete> {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.user?.stateLocation == '') {
          _textEditingController.text = '';
        }
      },
      child: BlocBuilder<CreateProfileCubit, CreateProfileState>(
        builder: (context, state) {
          final createProfileCubit = context.read<CreateProfileCubit>();
          List<String> states = List.from(state.states);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Autocomplete<String>(
                initialValue:
                    TextEditingValue(text: _textEditingController.text),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return states.where((state) {
                    return state
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String value) {
                  setState(() {
                    _isValid = true; // Restablecer validez al seleccionar
                  });
                  widget.onChanged(value);
                  createProfileCubit.selectState(value);
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
                    readOnly: widget.readOnly ?? true,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                    ),
                    decoration: CustomInputDecoration(
                      suffixIcon: widget.fieldActivatorWidget,
                      hintText: l10n.state,
                    ).decoration,
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                      _validateSelection(states);
                    },
                    validator: (value) {
                      print('value: $value');
                      if (value == null ||
                          value.isEmpty ||
                          !states.contains(value)) {
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
                        color: Colors.grey[800], // Fondo gris oscuro
                        child: ListView.builder(
                          padding: EdgeInsets.all(8.0),
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
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                  ), // Texto blanco con fuente Montserrat
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

  void _validateSelection(List<String> states) {
    setState(() {
      _isValid = states.contains(_textEditingController.text);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryCodeFormAutoComplete extends StatefulWidget {
  final String? initialValue;
  final List<String> items;
  final void Function(String?) onChanged;
  final bool? isCreated;

  const CountryCodeFormAutoComplete({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.items,
    this.isCreated = false,
  });

  @override
  State<CountryCodeFormAutoComplete> createState() =>
      _CountryCodeFormAutoCompleteState();
}

class _CountryCodeFormAutoCompleteState
    extends State<CountryCodeFormAutoComplete> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

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

  void _validateSelection(List<String> items) {
    setState(() {
      items.contains(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Autocomplete<String>(
            initialValue: widget.isCreated!
                ? TextEditingValue(text: widget.initialValue ?? '')
                : null,
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              final query = textEditingValue.text.toLowerCase();
              final List<String> filteredItems = widget.items
                  .where((item) => item.toLowerCase().contains(query))
                  .toList();
              if (query == '1' && filteredItems.contains('+1')) {
                filteredItems.remove('+1');
                filteredItems.insert(0, '+1');
              }
              return filteredItems;
            },
            onSelected: (String value) {
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
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                ),
                decoration: widget.isCreated!
                    ? CustomInputDecoration().decoration
                    : CustomInputDecoration().decoration.copyWith(
                          hintText: '+00',
                        ),
                onFieldSubmitted: (String value) {
                  onFieldSubmitted();
                  _validateSelection(widget.items);
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !widget.items.contains(value)) {
                    return l10n.pleaseSelectGenericValue;
                  }
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
                    width: 100,
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
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 14,
                              ),
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
        ),
      ],
    );
  }
}

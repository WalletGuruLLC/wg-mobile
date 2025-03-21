import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

import '../../../../application/core/validations/validations.dart';
import '../../styles/schemas/app_color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DatePickerForm extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateChanged;

  const DatePickerForm({
    super.key,
    this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<DatePickerForm> createState() => _DatePickerFormState();
}

class _DatePickerFormState extends State<DatePickerForm> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate;
  TextStyle defaultTextStyle = GoogleFonts.montserrat();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    _updateDateController();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.selectYourBirth;

    return BaseTextFormField(
      suffixIcon: const Icon(
        Icons.calendar_month_outlined,
        color: Colors.white,
      ),
      enabled: true,
      readOnly: true,
      decoration: CustomInputDecoration(hintText: hintText).decoration.copyWith(
          suffixIcon: GestureDetector(
              onTap: () => _selectDate(context),
              child: const Icon(Icons.calendar_month_outlined,
                  color: Colors.white))),
      hintStyle: AppTextStyles.formText,
      controller: _dateController,
      validator: (value, context) =>
          Validators.validateEmptyDate(value, context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo =
        DateTime(now.year - 18, now.month, now.day);
    final DateTime hundredYearsAgo =
        DateTime(now.year - 100, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? eighteenYearsAgo,
      firstDate: hundredYearsAgo,
      lastDate: eighteenYearsAgo,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
                primary: AppColorSchema.of(context).buttonColor),
            dialogBackgroundColor: Colors.white,
            textTheme: _buildTextStyle(),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _updateDateController();
        widget.onDateChanged(selectedDate);
        BlocProvider.of<CreateProfileCubit>(context)
            .setDateOfBirth(selectedDate.toString());
      });
    }
  }

  void _updateDateController() {
    _dateController.text =
        selectedDate != null ? "${selectedDate!.toLocal()}".split(' ')[0] : '';
  }

  TextTheme _buildTextStyle() {
    return TextTheme(
      displayLarge: defaultTextStyle,
      displayMedium: defaultTextStyle,
      displaySmall: defaultTextStyle,
      headlineLarge: defaultTextStyle,
      headlineMedium: defaultTextStyle,
      headlineSmall: defaultTextStyle,
      titleLarge: defaultTextStyle,
      titleMedium: defaultTextStyle,
      titleSmall: defaultTextStyle,
      bodyLarge: defaultTextStyle,
      bodyMedium: defaultTextStyle,
      bodySmall: defaultTextStyle,
      labelLarge: defaultTextStyle,
      labelMedium: defaultTextStyle,
      labelSmall: defaultTextStyle,
    );
  }
}

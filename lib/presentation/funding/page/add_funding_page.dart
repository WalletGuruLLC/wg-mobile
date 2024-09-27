import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class AddFundingPage extends StatefulWidget {
  const AddFundingPage({super.key});

  @override
  State<AddFundingPage> createState() => _AddFundingPageState();
}

class _AddFundingPageState extends State<AddFundingPage> {
  bool isChecked = false;

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showSimpleStyle: false,
      showLoggedUserAppBar: true,
      showBottomNavigationBar: false,
      actionAppBar: () => Navigator.pop(context),
      pageAppBarTitle: "Funding",
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    TextBase(
                      text: '100 USD',
                      fontSize: size.width * 0.05,
                    ),
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      checkColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.6),
                CustomButton(
                  border: Border.all(
                      color: AppColorSchema.of(context).buttonBorderColor),
                  color: isChecked
                      ? AppColorSchema.of(context).buttonColor
                      : Colors.transparent,
                  text: 'Funding',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onPressed: () =>
                      isChecked ? () => showConfirmDialog(context) : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Fund'),
          content: Text('Are you sure to fund this amount?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                // Aquí iría la lógica para añadir fondos
                // Por ahora, mostraremos un diálogo de error
                showErrorDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fund Error'),
          content: Text(
              'There was an error processing your fund. Please try again.'),
          actions: [
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/configuration_setting/widgets/configuration_option.dart';
import 'package:wallet_guru/presentation/configuration_setting/widgets/hide_notification_modal.dart';

class ConfigurationSettingView extends StatelessWidget {
  const ConfigurationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: size.height * .20),
        ConfigurationOption(
          optionTitle: l10n.hideNotification,
          onTap: () {
            _buildHideNotificationModal(context);
          },
        ),
        ConfigurationOption(
          optionTitle: l10n.inAppNotification,
        ),
        ConfigurationOption(
          optionTitle: l10n.activeOrDeactivateNotifications,
          showToggle: true,
        ),
        SizedBox(height: size.height * .065),
      ],
    );
  }

  Future<dynamic> _buildHideNotificationModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const HideNotificationModal();
      },
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showAppBar: true,
      showBottomNavigationBar: true,
      pageAppbarTitle: 'My Profile',
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: Container(),
          ),
        ),
      ],
    );
  }
}

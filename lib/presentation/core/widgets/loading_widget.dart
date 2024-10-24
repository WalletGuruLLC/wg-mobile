import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
    this.showSafeArea = true,
    this.showSimpleStyle = false,
    this.showLoggedUserAppBar = false,
    this.showBottomNavigationBar = false,
    this.size = 200,
  });

  final bool showSafeArea;
  final bool showSimpleStyle;
  final bool showLoggedUserAppBar;
  final bool showBottomNavigationBar;
  final double size;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WalletGuruLayout(
      showSafeArea: widget.showSafeArea,
      showSimpleStyle: widget.showSimpleStyle,
      showLoggedUserAppBar: widget.showLoggedUserAppBar,
      showBottomNavigationBar: widget.showBottomNavigationBar,
      backgroundColor: Colors.transparent,
      children: [
        SizedBox(
          width: 80.0,
          height: 80.0,
          child: Lottie.asset(
            'assets/load.json',
            controller: _animationController,
            onLoaded: (composition) {
              _animationController
                ..duration = composition.duration
                ..forward();
            },
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

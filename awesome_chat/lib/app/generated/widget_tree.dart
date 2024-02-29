import 'package:awesome_chat/app/common/authentication.dart';
import 'package:awesome_chat/app/modules/home/views/navigatorhome_screen.dart';
import 'package:awesome_chat/app/modules/login/views/login_screen.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshotdata) {
        if (snapshotdata.hasData) {
         return const NavigatorHomeScreen();
        } else {
         return const LoginScreen();
        }
      },
      stream: Auth().authenStateChanges,
    );
  }
}

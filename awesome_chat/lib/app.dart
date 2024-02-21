import 'package:awesome_chat/app/modules/login/views/login_screen.dart';
import 'package:awesome_chat/app/modules/splash/views/splash_screen.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AwesomeChat extends StatelessWidget {
  const AwesomeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouterName.Splash,
      onGenerateRoute:AppRouter.onGenerateRoute ,
      home: SplashScreen(),
    );
  }
}
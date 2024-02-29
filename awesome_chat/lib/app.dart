import 'package:awesome_chat/app/modules/home/views/navigatorhome_screen.dart';
import 'package:awesome_chat/app/modules/login/views/login_screen.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AwesomeChat extends StatelessWidget {
  const AwesomeChat({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouterName.Splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const NavigatorHomeScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0XFFFBC16A)),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

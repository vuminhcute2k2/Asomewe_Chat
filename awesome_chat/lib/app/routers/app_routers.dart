import 'package:awesome_chat/app/generated/widget_tree.dart';
import 'package:awesome_chat/app/modules/home/views/homepase_screen.dart';
import 'package:awesome_chat/app/modules/login/views/login_screen.dart';
import 'package:awesome_chat/app/modules/register/views/register_screen.dart';
import 'package:awesome_chat/app/modules/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';

class AppRouter {
  static GetPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterName.Splash:
        return GetPageRoute(
          page: () => const SplashScreen(),
          settings: settings,
        );
       case AppRouterName.WidgetTree:
        return GetPageRoute(
          page: () => const WidgetTree(),
          settings: settings,
        );
        case AppRouterName.Login:
        return GetPageRoute(
          page: () => const LoginScreen(),
          settings: settings,
        ); 
        case AppRouterName.Register:
        return GetPageRoute(
          page: () => const RegisterScreen(),
          settings: settings,
        );  
        case AppRouterName.Home:
        return GetPageRoute(
          page: () => const HomePaseScreen(),
          settings: settings,
        );      
    }
    return null;
  }
}
class AppRouterName{
  static const Splash = "/splash";
  static const WidgetTree = "/widgettree";
  static const Register = "/register";
  static const Login = "/login";
  static const Home = "/home";

}
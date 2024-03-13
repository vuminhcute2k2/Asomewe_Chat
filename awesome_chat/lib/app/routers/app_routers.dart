import 'package:awesome_chat/app/generated/widget_tree.dart';
import 'package:awesome_chat/app/modules/chat/views/chat_screen.dart';
import 'package:awesome_chat/app/modules/home/views/editaccount_screen.dart';
import 'package:awesome_chat/app/modules/home/views/homepase_screen.dart';
import 'package:awesome_chat/app/modules/home/views/listfriends_screen.dart';
import 'package:awesome_chat/app/modules/home/views/navigatorhome_screen.dart';
import 'package:awesome_chat/app/modules/home/views/profile_screen.dart';
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
          page: () =>const  HomePaseScreen(),
          settings: settings,
        );   
        case AppRouterName.NavigatorHome:
        return GetPageRoute(
          page: () => const NavigatorHomeScreen(),
          settings: settings,
        ); 
        case AppRouterName.Profile:
        return GetPageRoute(
          page: () => const ProfileScreen(),
          settings: settings,
        ); 
        case AppRouterName.EditAccount:
        return GetPageRoute(
          page: () => const EditAccountScreen(),
          settings: settings,
        );
        case AppRouterName.ListFriends:
        return GetPageRoute(
          page: () => const ListFriendsScreen(),
          settings: settings,
        );
        case AppRouterName.Chat:
        return GetPageRoute(
          page: () => const ChatScreen(),
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
  static const Profile='/profile';
  static const NavigatorHome = '/navigatorHome';
  static const EditAccount = '/editaccount';
  static const ListFriends ='/listfriends';
  static const Chat ='/chat';


}
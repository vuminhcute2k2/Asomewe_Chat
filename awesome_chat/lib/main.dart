import 'package:awesome_chat/app.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/requestfriends_controller.dart';
import 'package:awesome_chat/service/store_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Get.putAsync(() => SharedPreferences.getInstance());
  await Firebase.initializeApp();
  runApp(const AwesomeChat());
}




import 'package:awesome_chat/app/common/authentication.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences? prefs;
  @override
  void onInit() {
    super.onInit();
  }
  void initSharedPref() async {
    // Doi shared prefs nay phai khoi tao xong
    prefs = await SharedPreferences.getInstance();
    //
  }
  void loginUser() async {
    try {
      String res = await Auth().loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (res == "success") {
        Get.toNamed(AppRouterName.NavigatorHome);
      } else {
        // Hiển thị thông báo lỗi
        Get.defaultDialog(
          title: "Thông báo",
          middleText: "Sai tài khoản hoặc mật khẩu",
          confirm: ElevatedButton(
            onPressed: () => Get.back(),
            child: Text("Đóng"),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}

import 'package:awesome_chat/app/common/authentication.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth =FirebaseAuth.instance;
  void onRegister() async {
    // Gọi hàm signUpUser từ Auth controller
    await Auth().signUpUser(
      email: email.text.trim(),
      fullname: fullname.text.trim(),
      password: password.text.trim(),
      image: '',
      about: '',

    );

    // Lấy giá trị của biến error từ Auth controller
    String errorMessage = Auth().error.value;

    if (errorMessage.isEmpty) {
      // Đăng ký thành công,
      Get.toNamed(AppRouterName.Home);
    } else {
      // Hiển thị thông báo lỗi
      Get.snackbar('Error', errorMessage);
    }
  }
}
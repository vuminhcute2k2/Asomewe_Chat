import 'package:awesome_chat/app/modules/register/controller/register_controller.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 
  bool isChecked = false;
  RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, right: 30, left: 30),
            height: 800,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/img_arrow_left.svg',
                        width: 26,
                        height: 26,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color: Color(0XFF4356B4)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    'HỌ VÀ TÊN',
                    style: TextStyle(color: AppColors.colorGrayText),
                  ),
                ),
                TextField(
                  // onChanged:(value){
                  //   //registerController.fullname;
                  // },
                  controller:registerController.fullname,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(
                          15.0), // Điều chỉnh khoảng cách xung quanh biểu tượng
                      child: SvgPicture.asset(
                        'assets/images/img_user_2.svg',
                      ),
                    ),
                    hintText: 'username',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'EMAIL',
                    style: TextStyle(color: AppColors.colorGrayText),
                  ),
                ),
                TextField(
                  // onChanged:(value){
                  //   //registerController.fullname;
                  // },
                  controller:registerController.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(
                          15.0), // Điều chỉnh khoảng cách xung quanh biểu tượng
                      child: SvgPicture.asset(
                        'assets/images/img_lock.svg',
                      ),
                    ),
                    hintText: 'yourname@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'MẬT KHẨU',
                    style: TextStyle(color: AppColors.colorGrayText),
                  ),
                ),
                TextField(
                  controller:registerController.password,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(
                          15.0), // Điều chỉnh khoảng cách xung quanh biểu tượng
                      child: SvgPicture.asset(
                        'assets/images/img_key_1.svg',
                      ),
                    ),
                    hintText: 'password',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  ),
                  obscureText: true,
                  obscuringCharacter: '*',
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isChecked
                                  ? AppColors.colorVioletText
                                  : Colors.grey,
                              width: 2,
                            ),
                            color: isChecked
                                ? AppColors.colorVioletText
                                : Colors
                                    .transparent, // Thay đổi màu của checkbox
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (isChecked)
                                const Icon(
                                  Icons.check,
                                  color: Colors
                                      .white, // Đổi màu của icon để nó hiển thị trên nền màu của checkbox
                                  size: 18,
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Tôi đồng ý với các ",
                              style: TextStyle(
                                  color: AppColors.colorGrayText,
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: "chính sách",
                              style: TextStyle(
                                  color: AppColors.colorVioletText,
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: " và ",
                              style: TextStyle(
                                  color: AppColors.colorGrayText,
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: "điều khoản",
                              style: TextStyle(
                                  color: AppColors.colorVioletText,
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: GestureDetector(
                    onTap: () {
                      registerController.onRegister();
                    },
                    child: Container(
                      width: 350,
                      height: 52,
                      alignment: Alignment.center,
                      //padding: const EdgeInsets.symmetric(vertical: 20),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: AppColors.colorVioletText,
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: const Center(
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Đã có tài khoản? ",
                      style: TextStyle(color: AppColors.colorGrayText),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRouterName.Login);
                      },
                      child: const Text(
                        'Đăng nhập ngay',
                        style: TextStyle(color: AppColors.colorVioletText),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

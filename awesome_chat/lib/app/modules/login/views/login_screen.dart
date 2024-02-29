import 'package:awesome_chat/app/modules/login/controller/login_controller.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController =Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    loginController.initSharedPref();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 100, right: 30, left: 30),
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset('assets/images/logo_blue.svg')),
                  const Text(
                    'Trải nghiệm Awesome chat',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 26,
                        fontWeight: FontWeight.w300),
                  ),
                  const Text(
                    'Đăng nhập',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color: Color(0XFF4356B4)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding:  EdgeInsets.only(bottom: 0),
                    child: Text('EMAIL',style: TextStyle(color: AppColors.colorGrayText),),
                  ),
                  TextField(
                    // onChanged:(value){
                    //   //registerController.fullname;
                    // },
                    controller:loginController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding:const EdgeInsets.all(15.0), // Điều chỉnh khoảng cách xung quanh biểu tượng
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
                    child: Text('MẬT KHẨU',style: TextStyle(color: AppColors.colorGrayText),),
                  ),
                  TextField(
                   
                    controller:loginController.passwordController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding:const EdgeInsets.all(15.0), // Điều chỉnh khoảng cách xung quanh biểu tượng
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
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child:  Align(
                      alignment: Alignment.topRight,
                      child: Text('Quên mật khẩu?',style: TextStyle(color:AppColors.colorVioletText ),)),
                  ),
                  GestureDetector(
                        onTap: () {
                         loginController.loginUser();
                          // Navigator.pushNamed(context, AppRouterName.NavigatorHome);
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
                              'Đăng nhập',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Chưa có tài khoản? ",style: TextStyle(color: AppColors.colorGrayText),),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRouterName.Register);
                            },
                            child:const Text('Đăng ký ngay',style: TextStyle(color:AppColors.colorVioletText),),
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

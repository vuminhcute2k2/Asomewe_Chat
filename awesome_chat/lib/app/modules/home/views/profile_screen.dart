import 'package:awesome_chat/app/common/authentication.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/img_profile1.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Container(
              height: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 350),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.transparent,
                                    ),
                                    gradient: AppColors.backgroundColorApp,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: ClipRRect(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        'assets/images/img_profile1.png',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Awesome chat',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22),
                                      ),
                                      Text(
                                        'awesomechat@gmail.com',
                                        style: TextStyle(
                                            color: AppColors.colorGrayText,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRouterName.EditAccount);
                                    },
                                    child: SvgPicture.asset(
                                        'assets/images/img_pen.svg'),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 5,
                            color: const Color(0XFFEFEEEE),
                          ),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/images/img_global.svg"),
                                    ),
                                    const Text('Ngôn ngữ',style: TextStyle(fontSize: 18),),
                                  ],
                                )),
                                GestureDetector(
                                  onTap: () {},
                                  child:const Padding(
                                    padding:  EdgeInsets.all(8.0),
                                    child:  Text(
                                      'Tiếng Việt',
                                      style: TextStyle(
                                          color: AppColors.colorVioletText),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                    'assets/images/img_arrow_right.svg')
                              ],
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.only(left: 50,right: 10),
                            width: double.infinity,
                            height: 1,
                            color: AppColors.colorGrayText,),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/images/img_megaphone_1.svg"),
                                    ),
                                    const Text('Thông báo',style: TextStyle(fontSize: 18),),
                                  ],
                                )),
                                
                                SvgPicture.asset(
                                    'assets/images/img_arrow_right.svg'),
                              ],
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.only(left: 50,right: 10),
                            width: double.infinity,
                            height: 1,
                            color: AppColors.colorGrayText,),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/images/img_reuse_1.svg"),
                                    ),
                                    const Text('Phiên bản ứng dụng',style: TextStyle(fontSize: 18),),
                                  ],
                                )),
                                const Text('1.0.0',style: TextStyle(color: AppColors.colorGrayText,fontSize: 16),),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 5,
                            color: const Color(0XFFEFEEEE),
                          ),
                          GestureDetector(
                            onTap: () {
                              
                            },
                            child: GestureDetector(
                              onTap: ()async {
                                await Auth().logout();
                                Get.offAllNamed(AppRouterName.Login);
                              },
                              child: Container(
                                margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/images/img_logout_1_1.svg'),
                                    ),
                                    const Text('Đăng xuất',style: TextStyle(color: Colors.red,fontSize: 18),)
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

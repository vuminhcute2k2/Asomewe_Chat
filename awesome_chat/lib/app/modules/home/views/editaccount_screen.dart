import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: 800,
            child: Column(
              children: [
                Container(
                  width: 500,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: AppColors.backgroundColorApp,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/img_arrow_left.svg',
                                            width: 26,
                                            height: 26,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Chỉnh sửa thông tin',
                                        style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Text(
                                          'Lưu',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: Stack(
                              children: [
                                //show network img form document
                                Image.asset(
                                  'assets/images/img_profile1.png',
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                                Positioned(
                                  right: 0,
                                  bottom: 20,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 5,
                                        color: Colors.white,
                                      ),
                                      gradient: AppColors.backgroundColorApp,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: ClipRRect(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      borderRadius: BorderRadius.circular(40),
                                      child: const Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.white,
                                      ).onTap(() {}),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          // controller: loginController.emailController,
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
                            hintText: 'họ và tên',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.9)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'SỐ ĐIỆN THOẠI',
                            style: TextStyle(color: AppColors.colorGrayText),
                          ),
                        ),
                        TextField(
                          // onChanged:(value){
                          //   //registerController.fullname;
                          // },
                          // controller:loginController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(
                                  15.0), // Điều chỉnh khoảng cách xung quanh biểu tượng
                              child: SvgPicture.asset(
                                'assets/images/img_telephone_1.svg',
                              ),
                            ),
                            hintText: '+84',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.9)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'NGÀY SINH',
                            style: TextStyle(color: AppColors.colorGrayText),
                          ),
                        ),
                        TextField(
                          // onChanged:(value){
                          //   //registerController.fullname;
                          // },
                          // controller:loginController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(
                                  15.0), // Điều chỉnh khoảng cách xung quanh biểu tượng
                              child: SvgPicture.asset(
                                'assets/images/img_birthdaycake_1.svg',
                              ),
                            ),
                            hintText: 'dd/MM/yyyy',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.9)),
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
      ),
    );
  }
}

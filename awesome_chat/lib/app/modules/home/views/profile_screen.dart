import 'dart:io';

import 'package:awesome_chat/app/common/authentication.dart';
import 'package:awesome_chat/app/modules/home/controllers/profile_controller.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:awesome_chat/service/store_service.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: FutureBuilder(
          future: StoreServices.getUser(auth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Nếu dữ liệu đang được tải, hiển thị tiến trình chờ
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Nếu có lỗi khi tải dữ liệu, hiển thị thông báo lỗi
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              // Nếu không có dữ liệu, hiển thị thông báo không có dữ liệu
              return const Center(
                child: Text('No data available'),
              );
            } else {
              var data = snapshot.data!.docs[0].data();
              print("xin chao:${data}");
              if (data is Map && data.containsKey('image')) {
                var imageUrl = data['image'];
                print(auth.currentUser!.uid);
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image.asset(
                    //   'assets/images/img_profile1.png',
                    //   fit: BoxFit.cover,
                    // ),
                    profileController.imgpath.isEmpty && data['image'] == ''
                        ? Image.asset(
                            'assets/images/img_profile1.png',
                            fit: BoxFit.cover,
                          )
                        : profileController.imgpath.isNotEmpty
                            ? Image.file(File(profileController.imgpath.value))
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(
                                data['image'],
                                fit: BoxFit.cover,
                              ),
                    SingleChildScrollView(
                      child: SizedBox(
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 30),
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
                                                gradient:
                                                    AppColors.backgroundColorApp,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: profileController
                                                          .imgpath.isEmpty &&
                                                      data['image'] == ''
                                                  ? ClipRRect(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: Image.asset(
                                                        'assets/images/img_profile1.png',
                                                        fit: BoxFit.fill,
                                                      ))
                                                  : profileController
                                                          .imgpath.isNotEmpty
                                                      ? Image.file(File(
                                                              profileController
                                                                  .imgpath.value))
                                                          .box
                                                          .roundedFull
                                                          .clip(Clip.antiAlias)
                                                          .make()
                                                      : ClipRRect(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          child: Image.network(
                                                            data['image'],
                                                            fit: BoxFit.fill,
                                                          ))),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child:  Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                 data['fullname'],
                                                  style:const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 22),
                                                ),
                                                Text(
                                                  data['email'],
                                                  style:const TextStyle(
                                                      color:
                                                          AppColors.colorGrayText,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRouterName.EditAccount);
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                    "assets/images/img_global.svg"),
                                              ),
                                              const Text(
                                                'Ngôn ngữ',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          )),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Tiếng Việt',
                                                style: TextStyle(
                                                    color: AppColors
                                                        .colorVioletText),
                                              ),
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              'assets/images/img_arrow_right.svg')
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 50, right: 10),
                                      width: double.infinity,
                                      height: 1,
                                      color: AppColors.colorGrayText,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                    "assets/images/img_megaphone_1.svg"),
                                              ),
                                              const Text(
                                                'Thông báo',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          )),
                                          SvgPicture.asset(
                                              'assets/images/img_arrow_right.svg'),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 50, right: 10),
                                      width: double.infinity,
                                      height: 1,
                                      color: AppColors.colorGrayText,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                    "assets/images/img_reuse_1.svg"),
                                              ),
                                              const Text(
                                                'Phiên bản ứng dụng',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          )),
                                          const Text(
                                            '1.0.0',
                                            style: TextStyle(
                                                color: AppColors.colorGrayText,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 5,
                                      color: const Color(0XFFEFEEEE),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: GestureDetector(
                                        onTap: () async {
                                          await Auth().logout();
                                          Get.offAllNamed(AppRouterName.Login);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                    'assets/images/img_logout_1_1.svg'),
                                              ),
                                              const Text(
                                                'Đăng xuất',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18),
                                              )
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
                );
              }
            }
            return const SizedBox(); // Added this to make sure all code paths return a widget
          },
        ),
      ),
    );
  }
}

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
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  var controller = Get.put(ProfileController());
  // khởi tạo để lấy giá trị currentUser từ authentication
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    gradient: AppColors.backgroundColorApp,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Expanded(
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
                                        onTap: () async {
                                          if (controller.imgpath.isEmpty) {
                                           await controller.updateProfile(context);
                                            Get.offAllNamed(
                                                AppRouterName.NavigatorHome);
                                          } else {
                                            await controller.uploadImage();
                                            controller.updateProfile(context);
                                            Get.offAllNamed(
                                                AppRouterName.NavigatorHome);
                                          }
                                        },
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
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.04,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder(
                      future: StoreServices.getUser(auth.currentUser!.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Nếu dữ liệu đang được tải, hiển thị tiến trình chờ
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // Nếu có lỗi khi tải dữ liệu, hiển thị thông báo lỗi
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          // Nếu không có dữ liệu, hiển thị thông báo không có dữ liệu
                          return const Center(
                            child: Text('No data available'),
                          );
                        } else {
                          var data = snapshot.data!.docs[0].data();
                          print("xin chao:${data}");
                          if (data is Map && data.containsKey('image')) {
                            var imageUrl = data['image'];
                            print(currentUser!.uid);
                            controller.nameController.text = data['fullname'];
                            controller.birthdayController.text = data['birthday'];
                            controller.numberphoneController.text = data['numberphone'];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Obx(
                                    () => CircleAvatar(
                                      radius: 80,
                                      backgroundColor: Colors.white,
                                      child: Stack(
                                        children: [
                                          //show network img form document
                                          controller.imgpath.isEmpty && data['image'] ==''
                                          ? Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/147/147142.png",
                                            //color: Colors.white,
                                          )
                                          : controller.imgpath.isNotEmpty ? Image.file(File(controller.imgpath.value))
                                              .box
                                              .roundedFull
                                              .clip(Clip.antiAlias)
                                              .make():
                                              Image.network(data['image'],).box.roundedFull.clip(Clip.antiAlias).make(),
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
                                                gradient: AppColors
                                                    .backgroundColorApp,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: ClipRRect(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: const Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Colors.white,
                                                ).onTap(() {
                                                   Get.dialog(pickerDialog(context, controller));
                                                }),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 0),
                                  child: Text(
                                    'HỌ VÀ TÊN',
                                    style: TextStyle(
                                        color: AppColors.colorGrayText),
                                  ),
                                ),
                                TextField(
                                  // onChanged:(value){
                                  //   //registerController.fullname;
                                  // },
                                  controller: controller.nameController,
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
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.9)),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'SỐ ĐIỆN THOẠI',
                                    style: TextStyle(
                                        color: AppColors.colorGrayText),
                                  ),
                                ),
                                TextField(
                                  // onChanged:(value){
                                  //   //registerController.fullname;
                                  // },
                                  controller:controller.numberphoneController,
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
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.9)),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'NGÀY SINH',
                                    style: TextStyle(
                                        color: AppColors.colorGrayText),
                                  ),
                                ),
                                TextField(
                                  // onChanged:(value){
                                  //   //registerController.fullname;
                                  // },
                                  controller:controller.birthdayController,
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
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.9)),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                        return Container();
                      },
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
Widget pickerDialog(context, controller) {
  //setting listicons and titles
  var listTile = ['Camera', 'Gallery', 'Cancel'];
  var icons = [
    Icons.camera_alt_rounded,
    Icons.photo_size_select_large_rounded,
    Icons.cancel_rounded
  ];
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(12),
      color: Color(0XFF333333),
      child: Column(
        //setting size to min
        mainAxisSize: MainAxisSize.min,
        children: [
          //soucre.text.semiBold.white.make(),
          const Text('Chọn ảnh đại diện',style: TextStyle(fontSize: 16),),
          Divider(),
          const SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            children: List.generate(
                3,
                (index) => ListTile(
                      onTap: () {
                        //setting ontap according to index
                        switch (index) {
                          //ontap of camera
                          case 0:
                            //providing camera source
                            Get.back();
                            controller.pickImage(context, ImageSource.camera);
                            break;
                          //ontap of gallery
                          case 1:
                            //providing gallery source
                            Get.back();
                            controller.pickImage(context, ImageSource.gallery);
                            break;
                          //ontap of cancel
                          case 2:
                            //close dialog
                            Get.back();
                            break;
                        }
                      },
                      //getting icons from our list
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      //getting titles from our list
                      title: listTile[index].text.white.make(),
                    )),
          ),
        ],
      ),
    ),
  );
}
import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/allfriends_controller.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/friends_controller.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/requestfriends_controller.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/views/allfriends_screen.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/views/friends_screen.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/views/requestfriends_screen.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ListFriendsScreen extends StatefulWidget {
  const ListFriendsScreen({Key? key}) : super(key: key);

  @override
  State<ListFriendsScreen> createState() => _ListFriendsScreenState();
}

class _ListFriendsScreenState extends State<ListFriendsScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  final AllFriendsController allFriendsController =
      Get.put(AllFriendsController());
  // final RequestFriendsController requestFriendsController = Get.put(RequestFriendsController());
  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
    if (tabviewController != null) {
      Get.put(FriendsController());
      // Get.put(RequestFriendsController()); // Thêm controller mới
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 500,
              height: 250,
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Bạn bè",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Lato',
                                            fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: SvgPicture.asset(
                                        'assets/images/img_add_1_primary.svg',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                onChanged: (textEntered) {
                                  // searchController.nameSongText.value = textEntered;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Tìm kiếm tin nhắn.... ',
                                  hintStyle: const TextStyle(
                                      color: AppColors.colorGrayText),
                                  border: InputBorder.none,
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.search,
                                        color: AppColors.colorVioletText),
                                    onPressed: () {
                                      // searchController.initSearching();
                                    },
                                  ),
                                ),
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
            Flexible(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TabBar(
                        controller: tabviewController,
                        labelColor: AppColors.colorVioletText,
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            strokeAlign: BorderSide.strokeAlignCenter,
                            width: 3, // Độ dày của gạch chân
                            color: AppColors
                                .colorVioletText, // Màu sắc của gạch chân
                          ),
                          insets: EdgeInsets.symmetric(
                              horizontal:
                                  -30), // Khoảng cách giữa gạch chân và nội dung Tab
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              child: const Text(
                                'Bạn bè',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Lato',
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              child: const Text(
                                'Tất cả',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Lato',
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              child: const Text(
                                'Yêu cầu',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Lato',
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabviewController,
                        children: [
                          //ItemFriends(controller: Get.find<FriendsController>()),
                          ItemFriends(),
                          Obx(() {
                            if (allFriendsController.isLoading.value) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              return ItemAllFriends();
                            }
                          }),
                          Obx(() {
                            if (allFriendsController.isLoading.value) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              return RequestItem();
                              
                            }
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

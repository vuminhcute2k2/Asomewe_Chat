import 'package:awesome_chat/app/modules/home/views/homepase_screen.dart';
import 'package:awesome_chat/app/modules/home/views/listfriends_screen.dart';
import 'package:awesome_chat/app/modules/home/views/profile_screen.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigatorHomeScreen extends StatefulWidget {
  const NavigatorHomeScreen({super.key});

  @override
  State<NavigatorHomeScreen> createState() => _NavigatorHomeScreenState();
}

class _NavigatorHomeScreenState extends State<NavigatorHomeScreen> {
  SharedPreferences? prefs;
  String username = "";
  void initSharedPref() async {
    // Doi shared prefs nay phai khoi tao xong
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initSharedPref();
    getUserName();
    //_homeCubit.getItems();
    super.initState();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(snap.data());
  }

  int currentTab = 0;
  final List<Widget> screens = [
    //chuyển màn cho bottom bar
    HomePaseScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const  HomePaseScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
  shape: const CircularNotchedRectangle(),
  notchMargin: 10,
  child: Container(
    height: 100,
    padding: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded( // Đẩy icon đầu tiên ra lề trái
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =  HomePaseScreen();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/img_chat.svg',
                      color: currentTab == 0
                          ? AppColors.colorVioletText
                          : Colors.grey,
                    ),
                    Text(
                      "Tin nhắn",
                      style: TextStyle(
                        color: currentTab == 0
                            ? AppColors.colorVioletText
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded( // Đẩy icon thứ hai ra lề phải
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                   currentScreen = const ListFriendsScreen();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/img_friends.svg',
                      color: currentTab == 1
                          ? AppColors.colorVioletText
                          : Colors.grey,
                    ),
                    Text(
                      "Bạn bè",
                      style: TextStyle(
                        color: currentTab == 1
                            ? AppColors.colorVioletText
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MaterialButton(
          minWidth: 40,
          onPressed: () {
            setState(() {
              currentScreen = const ProfileScreen();
              currentTab = 2;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/img_profile.svg',
                color: currentTab == 2
                    ? AppColors.colorVioletText
                    : Colors.grey,
              ),
              Text(
                "Trang cá nhân",
                style: TextStyle(
                  color: currentTab == 2
                      ? AppColors.colorVioletText
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),

    );
  }
}

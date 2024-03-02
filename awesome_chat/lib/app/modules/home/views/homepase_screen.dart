import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePaseScreen extends StatefulWidget {
  const HomePaseScreen({super.key});

  @override
  State<HomePaseScreen> createState() => _HomePaseScreenState();
}

class _HomePaseScreenState extends State<HomePaseScreen> {
  final List<UserVartical> listvartical = [
    UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng  tôi dâdsdasda"),
    UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng  tôi dâdsdasda"),
    // UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng  tôi dâdsdasda"),
    // UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng tôi"),
    // UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng  tôi dâdsdasda"),
    // UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng  tôi dâdsdasda"),
    // UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng  tôi dâdsdasda"),
    // UserVartical(username: "Vuminh", message: "1 chấm sành điệu cùng  tôi dâdsdasda"),
  ];
  final List<UserHorizontal> listhorizontal = [
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user1"),
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user2"),
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user3"),
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user4"),
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user5"),
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user6"),
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user7"),
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        fullname: "user8"),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 800,
            child: Column(
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
                                            "Tin nhắn",
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
                                                Radius.circular(30)),
                                            color: Colors.white,
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: SvgPicture.asset(
                                            'assets/images/img_user.svg',
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
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listvartical.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:const EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: EdgeInsets.only(bottom: 10, right: 5),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: Image.network(
                                        listhorizontal[index].avatar,
                                      )),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            listvartical[index].username,
                                            textAlign: TextAlign.left,
                                            style:const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(listvartical[index].message),
                                        Container(width: double.infinity,height: 1,color: AppColors.colorGrayText,margin:const EdgeInsets.symmetric(vertical: 25),)
                                      ],
                                    ),
                                  ),
                                ),
                                const Text('11:24'),
                              ],
                            ),
                          );
                        }),
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

class UserVartical {
  final String username;
  final String message;

  UserVartical({required this.username, required this.message});
}

class UserHorizontal {
  final String avatar;
  final String fullname;

  UserHorizontal({required this.avatar, required this.fullname});
}

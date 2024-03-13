// import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/friends_controller.dart';
// import 'package:awesome_chat/themes/colors.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// Widget ItemFriends({required FriendsController controller}) {
//   return StreamBuilder(
//     stream: FirebaseFirestore.instance.collection('users').orderBy('fullname').snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//       if (snapshot.hasError) {
//         return Center(
//           child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
//         );
//       }
//       if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//         return const Center(
//           child: Text('Không có người dùng nào.'),
//         );
//       }

//       // Tạo một danh sách các nhóm dựa trên chữ cái đầu tiên của fullname
//       Map<String, List<DocumentSnapshot>> groupedUsers = {};
//       snapshot.data!.docs.forEach((DocumentSnapshot document) {
//         String fullname = (document.data() as Map<String, dynamic>)['fullname'];
//         String firstLetter = fullname[0].toUpperCase();
//         //kiem tra xem nhóm đã tồn tại chưa
//         if (!groupedUsers.containsKey(firstLetter)) {
//           groupedUsers[firstLetter] = [];
//         }
//         groupedUsers[firstLetter]!.add(document);
//       });

//       return Expanded(
//         child: ListView.builder(
//           itemCount: groupedUsers.length,
//           itemBuilder: (BuildContext context, int index) {
//             String letter = groupedUsers.keys.elementAt(index);
//             List<DocumentSnapshot> users = groupedUsers[letter]!;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Mục chứa chữ cái
//                 Container(
//                   width: double.infinity,
//                   color: AppColors.colorGrayBackground,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Text(
//                       letter,
//                       style:const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Danh sách người dùng trong mục
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics:const NeverScrollableScrollPhysics(),
//                   itemCount: users.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     DocumentSnapshot document = users[index];
//                     Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
//                     String fullname = userData['fullname'] ?? 'No name';
//                     String email = userData['email'] ?? 'No email'; 
//                     String photoUrl = userData['image'] ?? 'https://cdn-icons-png.flaticon.com/512/147/147142.png';
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(photoUrl),
//                       ),
//                       title: Text(fullname),
//                       subtitle: Text(email),
//                       // Thêm các trường thông tin khác của người dùng nếu cần
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//     },
//   );
// }

import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/friends_controller.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemFriends extends GetView<FriendsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              Expanded(
                  child: ListView.builder(
                    itemCount: controller.letters.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String letter = controller.letters[index];
                      final List<DocumentSnapshot> users = controller.groupedUsers[letter]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mục chứa chữ cái
                          Container(
                            width: double.infinity,
                            color: AppColors.colorGrayBackground,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                letter,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          // Danh sách người dùng trong mục
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: users.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DocumentSnapshot document = users[index];
                              final Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
                              final String fullname = userData['fullname'] ?? 'No name';
                              final String email = userData['email'] ?? 'No email'; 
                              final String photoUrl = userData['image'] ?? 'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj';
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(photoUrl)?? NetworkImage('https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj'),
                                ),
                                title: Text(fullname),
                                subtitle: Text(email),
                                // Thêm các trường thông tin khác của người dùng nếu cần
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
    );
  }
}

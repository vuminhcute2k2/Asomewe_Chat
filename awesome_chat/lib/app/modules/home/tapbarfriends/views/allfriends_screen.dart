import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/allfriends_controller.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemAllFriends extends GetView<AllFriendsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.letters.length,
              itemBuilder: (BuildContext context, int index) {
                final String letter = controller.letters[index];
                final List<DataSnapshot>? users =
                    controller.groupedUsers[letter];

                return users != null && users.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section header for the letter
                          Container(
                            width: double.infinity,
                            color: AppColors.colorGrayBackground,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              letter,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          // List of users for the letter
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: users.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DataSnapshot document = users[index];
                              final Map<dynamic, dynamic>? userDataMap =
                                  document.value as Map<dynamic, dynamic>?;

                              if (userDataMap != null) {
                                return Column(
                                  children: userDataMap.entries
                                      .where((entry) =>
                                          entry.value['fullname'][0]
                                              .toUpperCase() ==
                                          letter)
                                      .map((entry) {
                                    final String userId = entry.key;
                                    final Map<String, dynamic> userData =
                                        entry.value.cast<String, dynamic>();
                                    final String? fullname =
                                        userData['fullname'] as String?;
                                    final String? email =
                                        userData['email'] as String?;
                                    final String? photoUrl =
                                        userData['image'] as String?;
                                    print(
                                        'User ID: $userId, Fullname: $fullname, Email: $email');

                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(photoUrl ??
                                            'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj'),
                                      ),
                                      title: Text(fullname ?? 'No name'),
                                      subtitle: Text(email ?? 'No email'),
                                      trailing: GestureDetector(
                            
                                        onTap: () async {
                                          User? currentUser =
                                              FirebaseAuth.instance.currentUser;
                                          String? senderId;
                                          String? senderName;
                                          String? senderPhotoUrl;
                                          String? receiverId;
                                          String? receiverPhotoUrl;
                                          String? receiverName;

                                          if (currentUser != null) {
                                            senderId = currentUser.uid;
                                            receiverId = userId;

                                            try {
                                              DocumentSnapshot snapshot =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(senderId)
                                                      .get();
                                              Map<String, dynamic>? userData =
                                                  snapshot.data()
                                                      as Map<String, dynamic>?;

                                              if (userData != null) {
                                                senderName =
                                                    userData['fullname']
                                                        as String?;
                                                senderPhotoUrl =
                                                    userData['image']
                                                        as String?;
                                              }
                                            } catch (e) {
                                              // Xử lý lỗi khi lấy dữ liệu từ Cloud Firestore
                                              print(
                                                  'Error fetching user data: $e');
                                            }
                                          } else {
                                            // Xử lý trường hợp không có người dùng đăng nhập
                                          }

                                          if (senderId != null &&
                                              receiverId != null &&
                                              senderName != null) {
                                            controller.sendFriendRequest(
                                              senderId,
                                              receiverId,
                                              senderName,
                                              senderPhotoUrl,
                                              receiverPhotoUrl,
                                              receiverName,
                                            );
                                          } else {
                                            // Xử lý trường hợp không tìm thấy thông tin cần thiết
                                          }
                                        },

                                        child: Container(
                                          width: 73,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            color: AppColors.colorVioletText,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18)),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            'Kết bạn',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return const ListTile(
                                  title: Text('No data'),
                                );
                              }
                            },
                          ),
                        ],
                      )
                    : Container(); // Return an empty container if users list is empty
              },
            ),
    );
  }
}

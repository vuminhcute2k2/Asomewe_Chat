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
                                          bool isFriendRequestSent = controller.friendRequestStatus[userId]?.value ?? false;
                                          // Kiểm tra xem userId có phải là senderId và yêu cầu kết bạn đã được gửi
                                          if (userId == controller.currentUserID && isFriendRequestSent) {
                                            // Nếu đã gửi yêu cầu kết bạn, hủy yêu cầu
                                            controller.cancelFriendsRequest(userId);
                                          } else {
                                            // Nếu chưa gửi yêu cầu kết bạn, gửi yêu cầu mới
                                            User? currentUser = FirebaseAuth.instance.currentUser;
                                            if (currentUser != null) {
                                              String? senderId = currentUser.uid;
                                              String? senderName;
                                              String? senderPhotoUrl;
                                              String? receiverId = userData['uid'];
                                              String? receiverPhotoUrl = userData['image'];
                                              String? receiverName = userData['fullname'];

                                              try {
                                                DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(senderId).get();
                                                Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

                                                if (userData != null) {
                                                  senderName = userData['fullname'] as String?;
                                                  senderPhotoUrl = userData['image'] as String?;
                                                }
                                              } catch (e) {
                                                // Xử lý lỗi khi lấy dữ liệu từ Cloud Firestore
                                                print('Error fetching user data: $e');
                                              }

                                              if (senderId != null && receiverId != null && senderName != null) {
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
                                            } else {
                                              // Xử lý trường hợp không có người dùng đăng nhập
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 73,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: controller.isFriendRequestSent.value
                                                ? AppColors.colorVioletText
                                                : AppColors.colorVioletText,
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller.isFriendRequestSent.value ? 'Hủy' : 'Kết bạn',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
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
                    : Container();
              },
            ),
    );
  }
}



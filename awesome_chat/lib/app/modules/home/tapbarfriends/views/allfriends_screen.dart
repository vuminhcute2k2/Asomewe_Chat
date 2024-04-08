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
                                            //bool isFriendRequestSent = controller.friendRequestStatus[userId]?.value ?? false;
                                            bool isFriendRequestSent =
                                                controller
                                                        .isFriendRequestSentMap[
                                                            userId]
                                                        ?.value ??
                                                    false;
                                            if (isFriendRequestSent) {
                                              // Hủy yêu cầu kết bạn
                                              controller
                                                  .cancelFriendsRequest(userId);
                                              // Sau khi hủy, đặt lại trạng thái của nút được ấn thành "Kết bạn"
                                              // controller.friendRequestStatus[userId]?.value = false;
                                              controller
                                                  .isFriendRequestSentMap[
                                                      userId]
                                                  ?.value = false;
                                            } else {
                                              // Gửi yêu cầu kết bạn
                                              User? currentUser = FirebaseAuth.instance.currentUser;
                                              if (currentUser != null) {
                                                final senderId = currentUser.uid;
                                                final senderName = await controller.getSenderName(senderId);
                                                if (senderName != null) {
                                                  final senderPhotoUrl = currentUser.photoURL ?? '';
                                                  final receiverPhotoUrl = userData['image'] ?? '';
                                                  final receiverName = userData['fullname'] ?? '';
                                                  controller.sendFriendRequest(
                                                    senderId,
                                                    userId,
                                                    senderName,
                                                    senderPhotoUrl,
                                                    receiverPhotoUrl,
                                                    receiverName,

                                                  );
                                                  // Sau khi gửi yêu cầu, đặt lại trạng thái của nút được ấn thành "Hủy"
                                                  // controller.friendRequestStatus[userId]?.value = true;
                                                  controller.isFriendRequestSentMap[userId]?.value = true;
                                                }
                                              }

                                              // User? currentUser = FirebaseAuth
                                              //     .instance.currentUser;
                                              // if (currentUser != null) {
                                              //   final senderId =
                                              //       currentUser.uid;
                                              //   final receiverId = userData['uid']; // Lấy UID của người nhận từ dữ liệu người dùng
                                              //   final senderName =await controller.getSenderName(senderId);
                                              //   if (senderName != null &&
                                              //       receiverId != null) {
                                              //     final senderPhotoUrl =
                                              //         currentUser.photoURL ??
                                              //             '';
                                              //     final receiverPhotoUrl =
                                              //         userData['image'] ?? '';
                                              //     final receiverName =
                                              //         userData['fullname'] ??
                                              //             '';
                                              //     controller.sendFriendRequest(
                                              //       senderId,
                                              //       receiverId, // Sử dụng UID của người nhận
                                              //       senderName,
                                              //       senderPhotoUrl,
                                              //       receiverPhotoUrl,
                                              //       receiverName,
                                              //     );
                                              //     // Sau khi gửi yêu cầu, đặt lại trạng thái của nút được ấn thành "Hủy"
                                              //     controller
                                              //         .isFriendRequestSentMap[
                                              //             userId]
                                              //         ?.value = true;
                                              //   }
                                              // }

                                            }
                                          },
                                          child: Obx(
                                            () => Container(
                                              width: 73,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: controller
                                                            .isFriendRequestSentMap[
                                                                userId]
                                                            ?.value ??
                                                        false
                                                    ? AppColors.colorVioletText
                                                    : AppColors.colorVioletText,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  controller
                                                              .isFriendRequestSentMap[
                                                                  userId]
                                                              ?.value ??
                                                          false
                                                      ? 'Hủy'
                                                      : 'Kết bạn',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
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

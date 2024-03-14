

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

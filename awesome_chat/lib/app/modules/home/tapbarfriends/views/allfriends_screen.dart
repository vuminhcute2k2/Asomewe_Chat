import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/allfriends_controller.dart';
import 'package:awesome_chat/themes/colors.dart';
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
                final List<DataSnapshot> users =
                    controller.groupedUsers[letter]!;

                return Column(
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
                                    entry.value['fullname'][0].toUpperCase() ==
                                    letter)
                                .map((entry) {
                              final String userId = entry.key;
                              final Map<String, dynamic> userData = entry.value
                                  .cast<String,
                                      dynamic>(); // Cast the map to the expected type
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
                              );
                            }).toList(),
                          );
                        } else {
                          return ListTile(
                            title: Text('No data'),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}

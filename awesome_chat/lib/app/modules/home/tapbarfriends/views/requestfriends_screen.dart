import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/requestfriends_controller.dart';

class RequestItem extends StatelessWidget {
  final RequestFriendsController requestFriendsController = Get.put(RequestFriendsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (requestFriendsController.incomingRequests.isEmpty) {
          return const Center(
            child: Text('No friend requests'),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('LỜI MỜI KẾT BẠN',style: TextStyle(color: AppColors.colorGrayText,fontSize: 16,fontWeight: FontWeight.w600),)),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    itemCount: requestFriendsController.incomingRequests.length,
                    itemBuilder: (context, index) {
                      final request = requestFriendsController.incomingRequests[index];
                      final senderName = request['senderName'] ?? '';
                      final senderPhotoUrl = request['senderPhotoUrl'] ?? '';
                  
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(senderPhotoUrl),
                        ),
                        title: Text(
                          senderName,
                          style:const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Xử lý khi người dùng nhấn vào một lời mời kết bạn
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

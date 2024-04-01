import 'package:awesome_chat/model/request_friends.dart';
import 'package:awesome_chat/service/store_service.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/requestfriends_controller.dart';

class RequestItem extends StatelessWidget {
  final RequestFriendsController requestFriendsController =
      Get.put(RequestFriendsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (requestFriendsController.incomingRequests.isEmpty &&
            requestFriendsController.cancelRequests.isEmpty) {
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
                      child: Text(
                        'LỜI MỜI KẾT BẠN',
                        style: TextStyle(
                            color: AppColors.colorGrayText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 150,
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            await requestFriendsController.acceptFriendRequest(
                              FriendRequest(
                                senderId: request['senderId'] ?? '',
                                receiverId: request['receiverId'] ?? '',
                                senderName: request['senderName'] ?? '',
                                receiverName: request['receiverName'] ?? '',
                                senderPhotoUrl: request['senderPhotoUrl'] ?? '',
                                receiverPhotoUrl: request['receiverPhotoUrl'] ?? '',
                              ),
                              requestFriendsController.currentUserID!,
                            
                            );
                          },
                          child: Container(
                            width: 73,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: AppColors.colorVioletText,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            child: const Center(
                                child: Text(
                              'Đồng ý ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Color(0XFFEFEEEE),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ĐÃ GỬI KẾT BẠN',
                        style: TextStyle(
                            color: AppColors.colorGrayText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: ListView.builder(
                    itemCount: requestFriendsController.cancelRequests.length,
                    itemBuilder: (context, index) {
                      final requestCancel =
                          requestFriendsController.cancelRequests[index];
                      final receiverName = requestCancel['receiverName'] ?? '';
                      final receiverPhotoUrl =
                          requestCancel['receiverPhotoUrl'] ?? '';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(receiverPhotoUrl),
                        ),
                        title: Text(
                          receiverName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () async {},
                          child: Container(
                            width: 73,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: AppColors.colorVioletText,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            child: const Center(
                                child: Text(
                              'Hủy ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
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

import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/allfriends_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget ItemAllFriends() {
  return GetBuilder<AllFriendsController>(
    builder: (controller) {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      else if(controller.allFriendsData.isEmpty){
        return Center(child: Text("không có danh sách bạn bè"),);
      }

      return ListView.builder(
        itemCount: controller.allFriendsData.length,
        itemBuilder: (BuildContext context, int index) {
          String fullname = controller.allFriendsData[index]['fullname'] ?? 'Unknown';
          String email = controller.allFriendsData[index]['email'] ?? 'Unknown';
          String photoUrl = controller.allFriendsData[index]['image'] ??
              'https://cdn-icons-png.flaticon.com/512/147/147142.png';
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
            ),
            title: Text(fullname),
            subtitle: Text(email),
          );
        },
      );
    },
  );
}

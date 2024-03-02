import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget ItemFriends(BuildContext context){
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot.hasError) {
        return Center(
          child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
        );
      }
      if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
        return Center(
          child: Text('Không có người dùng nào.'),
        );
      }
      return Expanded(
        child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
            String fullname = userData['fullname'] ?? 'No name';
            String email = userData['email'] ?? 'No email'; 
            String photoUrl = userData['image'] ?? 'https://cdn-icons-png.flaticon.com/512/147/147142.png';
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(photoUrl),
              ),
              title: Text(fullname),
              subtitle: Text(email),
              // Thêm các trường thông tin khác của người dùng nếu cần
            );
          },
        ),
      );
    },
  );
}

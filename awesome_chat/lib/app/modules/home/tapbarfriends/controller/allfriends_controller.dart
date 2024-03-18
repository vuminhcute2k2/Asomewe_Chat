import 'dart:convert';

import 'package:awesome_chat/model/request_friends.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';


import 'package:get/get.dart';

class AllFriendsController extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final SharedPreferences _prefs = Get.find();

  RxBool isLoading = true.obs;
  List<Map<String, dynamic>> allFriendsData = [];
  Map<String, List<DataSnapshot>> groupedUsers =
      <String, List<DataSnapshot>>{}.obs;
  RxList<String> letters = <String>[].obs;
  @override
  void onInit() {
    fetchFriends();
    fetchAllFriends(); // lấy dữ liệu từ Realtime Database
    super.onInit();
  }

//hàm chuyển đổi dữ liệu từ cloud firestore về local rồi update dữ liệu lên realtime
  Future<void> fetchFriends() async {
    isLoading.value = true;
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      final List<Map<String, dynamic>> userDataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print('Fetched data from Firestore: $userDataList');
      //ma hoa thanh file chuoi json
      final jsonString = json.encode(userDataList);
      print('Json String: $jsonString');
      //chuyen du lieu ve local
      await _prefs.setString('userData', jsonString);

      print('Saved data to SharedPreferences: $jsonString');
      //update len realtime
      await updateFriendsOnRealtimeDatabase(userDataList);

      print('Updated data on Realtime Database');
    } catch (e) {
      print('Error fetching friends: $e');
    } finally {
      isLoading.value = false;
    }
  }

  //hàm cập nhật dữ liệu lên realtime
  Future<void> updateFriendsOnRealtimeDatabase(
      List<Map<String, dynamic>> dataList) async {
    print('Start updating friends on Realtime Database...');
    try {
      // Xóa dữ liệu cũ trên Realtime Database
      await _database.child('all_friends').remove();
      // Tạo một danh sách các Future để chờ hoàn thành tất cả các lệnh set
      List<Future<void>> futures = [];

      // Duyệt qua từng mục trong danh sách dữ liệu
      dataList.asMap().forEach((index, data) {
        // Tạo một tham chiếu đến nút cụ thể trong Firebase Realtime Database
        DatabaseReference reference = _database.child('all_friends').push();

        // Thêm lệnh set dữ liệu vào danh sách Future
        futures.add(reference.set(data));
      });

      // Chờ cho tất cả các lệnh set hoàn thành
      await Future.wait(futures);

      // Cập nhật biến allFriendsData với dữ liệu mới từ Realtime Database
      allFriendsData.clear();
      allFriendsData.addAll(dataList);

      print('Successfully updated friends on Realtime Database');
    } catch (e) {
      print('Error updating friends on Realtime Database: $e');
    }
  }

//hàm để cập nhật dữ liệu trên realtime vào allFriendsData để cập nhật dữ liệu lên màn hình

  Future<void> fetchAllFriends() async {
    isLoading(true);
    try {
      // Thực hiện theo dõi sự kiện thay đổi dữ liệu từ Realtime Database
      _database
          .child('all_friends')
          .orderByChild('fullname')
          .onValue
          .listen((event) {
        final dataSnapshot = event.snapshot;

        final Map<dynamic, dynamic>? dataSnapshotValue =
            dataSnapshot.value as Map<dynamic, dynamic>?;

        if (dataSnapshotValue != null) {
          // Tạo một list để lưu các chữ cái đầu tiên
          List<String> newLetters = [];
          // // Tạo một list để lưu các chữ cái đầu tiên và sắp xếp chúng theo thứ tự bảng chữ cái
          // List<String> newLetters = dataSnapshotValue.keys
          //     .map<String>((key) => key.substring(0, 1).toUpperCase())
          //     .toSet()
          //     .toList()
          //   ..sort();
          // Tạo một map để nhóm người dùng có cùng chữ cái đầu tiên vào 1 nhóm
          Map<String, List<DataSnapshot>> newGroupedUsers = {};

          dataSnapshotValue.forEach((key, value) {
            if (value is Map<dynamic, dynamic>) {
              String? fullname = value['fullname'];
              if (fullname != null && fullname.isNotEmpty) {
                String firstLetter = fullname[0].toUpperCase();
                // Kiểm tra xem đã có chữ cái đầu tiên chưa, nếu chưa thì tạo mới
                if (!newGroupedUsers.containsKey(firstLetter)) {
                  newLetters.add(firstLetter);
                  newGroupedUsers[firstLetter] = [];
                }

                // Tạo một đối tượng DataSnapshot và thêm vào nhóm tương ứng
                DataSnapshot snapshot = event.snapshot;
                newGroupedUsers[firstLetter]!.add(snapshot);
              }
            }
          });

          // Cập nhật danh sách chữ cái đầu tiên
          letters.assignAll(newLetters);
          // Cập nhật nhóm người dùng
          groupedUsers.assignAll(newGroupedUsers);
        }

        isLoading(false); // Đánh dấu là đã tải xong dữ liệu
      });
    } catch (e) {
      // Xử lý lỗi
      isLoading(false); // Đánh dấu là đã tải xong dữ liệu (nếu có lỗi)
    }
  }
  //hàm gửi lời mời kết bạn 
  void sendFriendRequest(String senderId, String receiverId, String senderName, String? senderPhotoUrl, String? receiverPhotoUrl,String? receiverName) {
  FriendRequest friendRequest = FriendRequest(
    senderId: senderId,
    receiverId: receiverId,
    senderName: senderName,
    receiverName: receiverName ?? '',
    senderPhotoUrl: senderPhotoUrl ?? '',
    receiverPhotoUrl: receiverPhotoUrl ?? '',
  );

  DatabaseReference reference = _database.child('request_friends').push();
  reference.set(friendRequest.toJson()).then((value) {
    // Cập nhật thành công, có thể hiển thị thông báo hoặc thực hiện các hành động khác ở đây
    print('Friend request sent successfully');
  }).catchError((error) {
    // Xử lý lỗi khi gửi yêu cầu kết bạn
    print('Error sending friend request: $error');
  });
}


Future<String?> getSenderName(String senderId) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
      String? senderName = userData['fullname'] as String?;
      return senderName;
    } else {
      return null;
    }
  } catch (e) {
    print('Error getting sender name: $e');
    return null;
  }
}
Future<Map<String, dynamic>?> getUserData(String userId) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  } catch (e) {
    print('Error getting user data: $e');
    return null;
  }
}


}

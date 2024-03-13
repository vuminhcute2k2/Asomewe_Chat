import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFriendsController extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final SharedPreferences _prefs = Get.find();

  RxBool isLoading = true.obs;
  List<Map<String, dynamic>> allFriendsData = [];

  @override
  void onInit() {
    fetchFriends();
    fetchAllfriends(); // lấy dữ liệu từ Realtime Database
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
       // Sắp xếp danh sách bạn bè theo tên (hoặc một trường dữ liệu khác)
      // userDataList.sort((a, b) => a['fullname'].compareTo(b['fullname']));

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
  Future<void> fetchAllfriends() async {
    isLoading.value = true;
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('all_friends').get();
      final List<Map<String, dynamic>> friendsDataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print('Fetched data from Realtime Database: $friendsDataList');

      // Cập nhật danh sách bạn bè vào biến allFriendsData của AllFriendsController
      allFriendsData.clear();
      allFriendsData.addAll(friendsDataList);

      // Kích hoạt sự kiện build để cập nhật danh sách bạn bè trên màn hình
      update();

      print('Updated friends list on the screen');
    } catch (e) {
      print('Error fetching friends from Realtime Database: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

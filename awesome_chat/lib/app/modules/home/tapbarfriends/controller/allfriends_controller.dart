import 'dart:convert';
import 'package:awesome_chat/model/request_friends.dart';
import 'package:awesome_chat/themes/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFriendsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final SharedPreferences _prefs = Get.find();
  String? currentUserID;
  RxBool isLoading = false.obs;
  RxBool isFriendRequestSent = false.obs;
  List<Map<String, dynamic>> allFriendsData = [];
  Map<String, List<DataSnapshot>> groupedUsers = <String, List<DataSnapshot>>{}.obs;
  RxList<String> letters = <String>[].obs;
  Stream<bool> get friendRequestSentStream => isFriendRequestSent.stream;
  Map<String, RxBool> friendRequestStatus = {};

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        currentUserID = user.uid;
        fetchFriends();
        fetchAllFriends();
        super.onInit();
      } else {
        currentUserID = null;
      }
    });
  }

  Future<void> fetchFriends() async {
    isLoading.value = true;
  try {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(AppStrings.users).get();
    final List<Map<String, dynamic>> userDataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // Clear current status
    friendRequestStatus.clear();

    // Update status for each user
    for (final userData in userDataList) {
      final String userId = userData['uid'];
      final bool isSent = await checkFriendRequestSent(userId); // Chờ kết quả trả về từ hàm checkFriendRequestSent
      friendRequestStatus[userId] = isSent.obs; // Lưu trạng thái của từng người dùng
    }

    final jsonString = json.encode(userDataList);
    await _prefs.setString('userData', jsonString);

    await updateFriendsOnRealtimeDatabase(userDataList);
  } catch (e) {
    print('Error fetching friends: $e');
  } finally {
    isLoading.value = false;
  }
  }

  Future<void> updateFriendsOnRealtimeDatabase(
      List<Map<String, dynamic>> dataList) async {
    print('Start updating friends on Realtime Database...');
    try {
      await _database.child(AppStrings.allfriends).remove();

      List<Future<void>> futures = [];

      dataList.asMap().forEach((index, data) {
        DatabaseReference reference = _database.child(AppStrings.allfriends).push();
        futures.add(reference.set(data));
      });

      await Future.wait(futures);

      allFriendsData.clear();
      allFriendsData.addAll(dataList);

      print('Successfully updated friends on Realtime Database');
    } catch (e) {
      print('Error updating friends on Realtime Database: $e');
    }
  }

  Future<void> fetchAllFriends() async {
    isLoading(true);
    try {
      _database
          .child(AppStrings.allfriends)
          .orderByChild('fullname')
          .onValue
          .listen((event) {
        final dataSnapshot = event.snapshot;
        final Map<dynamic, dynamic>? dataSnapshotValue =
            dataSnapshot.value as Map<dynamic, dynamic>?;

        if (dataSnapshotValue != null) {
          List<String> newLetters = [];
          Map<String, List<DataSnapshot>> newGroupedUsers = {};

          dataSnapshotValue.forEach((key, value) {
            if (value is Map<dynamic, dynamic>) {
              String? fullname = value['fullname'];
              if (fullname != null && fullname.isNotEmpty) {
                String firstLetter = fullname[0].toUpperCase();
                if (!newGroupedUsers.containsKey(firstLetter)) {
                  newLetters.add(firstLetter);
                  newGroupedUsers[firstLetter] = [];
                }

                DataSnapshot snapshot = event.snapshot;
                newGroupedUsers[firstLetter]!.add(snapshot);
              }
            }
          });

          letters.assignAll(newLetters);
          groupedUsers.assignAll(newGroupedUsers);
        }

        isLoading(false);
      });
    } catch (e) {
      isLoading(false);
    }
  }

  void sendFriendRequest(String senderId, String receiverId, String senderName,
      String? senderPhotoUrl, String? receiverPhotoUrl, String? receiverName) {
    FriendRequest friendRequest = FriendRequest(
    senderId: senderId,
    receiverId: receiverId,
    senderName: senderName,
    receiverName: receiverName ?? '',
    senderPhotoUrl: senderPhotoUrl ?? '',
    receiverPhotoUrl: receiverPhotoUrl ?? '',
  );

  DatabaseReference reference = _database.child(AppStrings.requestfriends).push();
  reference.set(friendRequest.toJson()).then((value) {
    // Gửi yêu cầu kết bạn thành công
    friendRequestStatus[receiverId]?.value = true; // Cập nhật trạng thái của người dùng cụ thể
    print('aaaaa : $friendRequestStatus');
    // Cập nhật lại trạng thái và giao diện
    isFriendRequestSent.value = true;
    print('bbbbb: $isFriendRequestSent');
    // Cập nhật trạng thái nút "Kết bạn" của người nhận thành "Hủy"
    update();
  }).catchError((error) {
    print('Error sending friend request: $error');
    // Xử lý lỗi khi gửi yêu cầu kết bạn
  });
  }

  void cancelFriendsRequest(String receiverId) {
  _database
      .child(AppStrings.requestfriends)
      .orderByChild('senderId')
      .equalTo(currentUserID)
      .once()
      .then((snapshot) {
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic>? data =
          snapshot.snapshot.value as Map<dynamic, dynamic>?;
      data?.forEach((key, value) {
        if (value['receiverId'] == receiverId) {
          _database.child(AppStrings.requestfriends).child(key).remove().then((value) {
            // Hủy yêu cầu kết bạn thành công
            friendRequestStatus[receiverId]?.value = false; // Cập nhật trạng thái của người dùng cụ thể
            // Cập nhật lại trạng thái và giao diện
            isFriendRequestSent.value = false;
          }).catchError((error) {
            print('Error cancelling friend request: $error');
            // Xử lý lỗi khi hủy yêu cầu kết bạn
          });
        }
      });
    }
  });
}


  Future<bool> checkFriendRequestSent(String? receiverId) async {
    try {
    DatabaseEvent event = await _database
        .child(AppStrings.requestfriends)
        .orderByChild('receiverId')
        .equalTo(receiverId)
        .once();

    if (event.snapshot.value != null) {
      Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;

      // Kiểm tra xem có bất kỳ yêu cầu nào từ senderId tới receiverId không
      return data!.values.any((value) => value['receiverId'] == receiverId);
    } else {
      return false;
    }
  } catch (e) {
    print('Error checking friend request status: $e');
    return false;
  }
  }

  Future<String?> getSenderName(String senderId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(AppStrings.users)
          .doc(senderId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;
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
          .collection(AppStrings.users)
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

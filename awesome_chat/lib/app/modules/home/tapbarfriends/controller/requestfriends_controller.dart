import 'package:awesome_chat/app/modules/home/tapbarfriends/controller/allfriends_controller.dart';
import 'package:awesome_chat/model/request_friends.dart';
import 'package:awesome_chat/themes/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RequestFriendsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  String? currentUserID;
  RxList<Map<String, dynamic>> incomingRequests = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> cancelRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        currentUserID = user.uid;
        fetchIncomingRequests();
        fetchCancelRequest();
      } else {
        currentUserID = null;
        incomingRequests.clear();
      }
    });
  }
  void removeCanceledRequest(String receiverId) {
  incomingRequests.removeWhere((request) => request['senderId'] == receiverId);
  }
  void fetchIncomingRequests() {
    if (currentUserID == null) {
      return;
    }
    _database
        .child(AppStrings.requestfriends)
        .orderByChild('receiverId')
        .equalTo(currentUserID)
        .onValue
        .listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot != null && dataSnapshot.value != null) {
        final Map<dynamic, dynamic>? data =
            dataSnapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          List<Map<String, dynamic>> requests = [];
          data.forEach((key, value) {
            if (value['receiverId'] == currentUserID) {
              requests.add({
                'key': key,
                'senderId': value['senderId'],
                'senderName': value['senderName'],
                'senderPhotoUrl': value['senderPhotoUrl'],
                'receiverName': value['receiverName'],
                'receiverPhotoUrl': value['receiverPhotoUrl'],
                'receiverId': value['receiverId']
              });
            }
          });
          incomingRequests.value = requests;
        }
      }
    });
  }

  void fetchCancelRequest() {
    if (currentUserID == null) {
      return;
    }
    _database
        .child(AppStrings.requestfriends)
        .orderByChild('senderId')
        .equalTo(currentUserID)
        .onValue
        .listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot != null && dataSnapshot.value != null) {
        final Map<dynamic, dynamic>? data =
            dataSnapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          List<Map<String, dynamic>> requestsCancel = [];
          data.forEach((key, value) {
            if (value['senderId'] == currentUserID) {
              requestsCancel.add({
                'receiverId': value['receiverId'],
                'receiverName': value['receiverName'],
                'receiverPhotoUrl': value['receiverPhotoUrl'],
                'senderId': value['senderId'],
                'senderName': value['senderName'],
                'senderPhotoUrl': value['senderPhotoUrl'],
              });
            }
          });
          cancelRequests.value = requestsCancel;
        }
      }
    });
  }
//hủy lời mời kết bạn 
void cancelFriendRequest(String senderId, String receiverId) {
  try {
    DatabaseReference reference = _database.child('request_friends');

    // Tìm và xóa yêu cầu kết bạn dựa trên senderId và receiverId
    reference
        .orderByChild('senderId')
        .equalTo(senderId)
        .once()
        .then((snapshot) {
      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map<dynamic, dynamic>?; // Chuyển đổi kiểu dữ liệu
        data?.forEach((key, value) {
          if (value['receiverId'] == receiverId) {
            reference.child(key).remove().then((value) {
              // Xóa yêu cầu kết bạn thành công
              print('Friend request deleted successfully.');
            }).catchError((error) {
              // Xử lý lỗi khi xóa yêu cầu kết bạn
              print('Error deleting friend request: $error');
            });
          }
        });
      }
    });

    // Xóa yêu cầu kết bạn khỏi danh sách yêu cầu đến của người dùng hiện tại
    removeCanceledRequest(receiverId);
  } catch (e) {
    print('Error deleting friend request: $e');
  }
}



//đồng ý lời mời kết bạn 
Future<void> acceptFriendRequest(FriendRequest friendRequest, String currentUserID) async {
  
  // Thêm thông tin của người đồng ý kết bạn vào nút friends của người gửi yêu cầu
  await addFriend(currentUserID, {
    'userId': friendRequest.senderId,
    'userName': friendRequest.senderName,
    'userPhotoUrl': friendRequest.senderPhotoUrl,
  });

  // Thêm thông tin của người gửi yêu cầu vào nút friends của người đồng ý kết bạn
  await addFriend(friendRequest.senderId, {
  'userId': currentUserID,
  'userName': friendRequest.receiverName,
  'userPhotoUrl': friendRequest.receiverPhotoUrl,
});

  // Xóa dữ liệu của id trùng với receiverId trong nút request_friends
  await _database
      .child(AppStrings.requestfriends)
      .orderByChild('receiverId')
      .equalTo(currentUserID)
      .once()
      .then((snapshot) {
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map<dynamic, dynamic>?;
      data?.forEach((key, value) {
        if (value['receiverId'] == currentUserID) {
          _database.child(AppStrings.requestfriends).child(key).remove();
        }
      });
    }
  });
  
}

Future<void> addFriend(String userId, Map<String, dynamic> friendInfo) async {
    await _database
        .child(AppStrings.friends)
        .child(userId)
        .child(friendInfo['userId'])
        .set(friendInfo);
        
  }

 


}

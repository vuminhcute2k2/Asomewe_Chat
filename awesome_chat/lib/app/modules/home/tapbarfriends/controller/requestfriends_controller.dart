import 'package:awesome_chat/model/request_friends.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RequestFriendsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

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

  void fetchIncomingRequests() {
    if (currentUserID == null) {
      return;
    }
    _database
        .child('request_friends')
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
        .child('request_friends')
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
                'receiverName': value['receiverName'],
                'receiverPhotoUrl': value['receiverPhotoUrl'],
              });
            }
          });
          cancelRequests.value = requestsCancel;
        }
      }
    });
  }

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
      .child('request_friends')
      .orderByChild('receiverId')
      .equalTo(currentUserID)
      .once()
      .then((snapshot) {
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map<dynamic, dynamic>?;
      data?.forEach((key, value) {
        if (value['receiverId'] == currentUserID) {
          _database.child('request_friends').child(key).remove();
        }
      });
    }
  });
  print('receiverName: ${friendRequest.receiverName}');
  print('receiverPhotoUrl: ${friendRequest.receiverPhotoUrl}');
  print('senderName: ${friendRequest.senderName}');
  print('senderPhotoUrl: ${friendRequest.senderPhotoUrl}');
  
  
}

Future<void> addFriend(String userId, Map<String, dynamic> friendInfo) async {
    await _database
        .child('friends')
        .child(userId)
        .child(friendInfo['userId'])
        .set(friendInfo);
        
  }


}

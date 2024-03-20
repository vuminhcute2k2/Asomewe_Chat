

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RequestFriendsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance;

  String? currentUserID;
  RxList<Map<String, dynamic>> incomingRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        currentUserID = user.uid;
        fetchIncomingRequests();
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
        .ref()
        .child('request_friends')
        .orderByChild('receiverId')
        .equalTo(currentUserID)
        .onValue
        .listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot != null && dataSnapshot.value != null) {
        final Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>?; 
        if (data != null) {
          List<Map<String, dynamic>> requests = [];
          data.forEach((key, value) {
            if (value['receiverId'] == currentUserID) {
              requests.add({
                'senderName': value['senderName'],
                'senderPhotoUrl': value['senderPhotoUrl'],
              });
            }
          });
          incomingRequests.value = requests;
        }
      }
    });
  }
}

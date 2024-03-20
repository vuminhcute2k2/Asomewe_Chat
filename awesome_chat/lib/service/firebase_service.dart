import 'package:awesome_chat/model/request_friends.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<String?> getCurrentUserID() async {
    final User? currentUser = _auth.currentUser;
    return currentUser?.uid;
  }

  Future<List<FriendRequest>> getIncomingFriendRequests(String userID) async {
    try {
      List<FriendRequest> requests = [];

      _database
          .child('request_friends')
          .orderByChild('receiverId')
          .equalTo(userID)
          .onValue
          .listen((event) {
        if (event.snapshot.value != null && event.snapshot.value is Map<dynamic, dynamic>) {
          Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            requests.add(FriendRequest.fromJson(value));
          });
        }
      });

      return requests;
    } catch (error) {
      throw error;
    }
  }
}

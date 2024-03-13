import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxBool isLoading = true.obs;
  final RxList<String> letters = <String>[].obs;
  final RxMap<String, List<DocumentSnapshot>> groupedUsers = <String, List<DocumentSnapshot>>{}.obs;

  @override
  void onInit(){
    fetchFriends();
    super.onInit();
  }
  //hàm xắp xếp danh sách friends
  void fetchFriends() async {
    isLoading(true);
    try {
      final QuerySnapshot querySnapshot = await _firestore.collection('users').orderBy('fullname').get();
      //tạo ra 1 list để lưu các chữ cái đầu tiên
      final List<String> newLetters = [];
      //tạo ra 1 map để nhóm người dùng có cùng chữ cái đầu tiên vào 1 nhóm
      final Map<String, List<DocumentSnapshot>> newGroupedUsers = {};
      //duyệt từng phần tử 
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        final String fullname = (document.data() as Map<String, dynamic>)['fullname'];
        final String firstLetter = fullname[0].toUpperCase();
        //kiểm tra xem đã có chữ cái đầu tiên chưa nếu chưa thì sẽ tạo ra danh sách với chữ cái đầu tiên mới 
        if (!newGroupedUsers.containsKey(firstLetter)) {
          newLetters.add(firstLetter);
          newGroupedUsers[firstLetter] = [];
        }
        newGroupedUsers[firstLetter]!.add(document);
      });
      //cập nhật danh sách chữ cái đầu tiên 
      letters.assignAll(newLetters);
      //cập nhật nhóm friends 
      groupedUsers.assignAll(newGroupedUsers);
    } catch (e) {
      // Xử lý lỗi
    } finally {
      isLoading(false);
    }
  }
}
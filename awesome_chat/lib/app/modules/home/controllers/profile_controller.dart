
import 'package:awesome_chat/model/user.dart';
import 'package:awesome_chat/service/store_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io' as io;
import 'package:path/path.dart';


class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var numberphoneController = TextEditingController();
  var birthdayController = TextEditingController();
  //variables for image
  var imgpath = ''.obs;
  var imglink = '';
  var shouldReload = false.obs;
  static ProfileController get instance => Get.find<ProfileController>();
  Rx<User?> userData = Rx<User?>(null);
  @override
  void onInit() {
    super.onInit();
    ever<User?>(userData, (newUserData) {
      //cập nhật giao diện người dùng khi có sự thay đổi trong dữ liệu người dùng
      if (newUserData != null) {
        nameController.text = newUserData.fullname;
        numberphoneController.text = newUserData.numberphone;
        birthdayController.text = newUserData.birthday;
      }
    });
  }
  void reloadPage() {
    shouldReload.toggle();
  }
  loadUserData() async {
   ProfileController profileController = Get.find();
    // Gọi hàm lấy dữ liệu từ Firebase hoặc nơi bạn lưu trữ dữ liệu người dùng
    User? newUser = await fetchDataFromFirebase();
    // Cập nhật dữ liệu người dùng trong GetX controller
    userData(newUser);
    // Gọi update() để thông báo cho GetX rằng dữ liệu đã thay đổi và cần cập nhật giao diện
    update();
  }

  Future<User?> fetchDataFromFirebase() async {
    try {
      print(1);
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      print(2);

      if (userDoc.exists) {
        // Chuyển đổi dữ liệu từ Firestore thành đối tượng UserData
        User userData = User(
          email: userDoc['email'],
          birthday: userDoc['birthday'],
          numberphone: userDoc['numberphone'],
          uid: userDoc['uid'],
          image: userDoc['image'],
          fullname: userDoc['fullname'],
          password: userDoc['password'],
          followers: List.from(userDoc['followers']),
          following: List.from(userDoc['following']),
        );
        print(userData);
        return userData;
      } else {
        // Nếu tài khoản không tồn tại, trả về null 
        return null;
      }
    } catch (e) {
      // Xử lý lỗi khi truy vấn dữ liệu từ Firebase
      print('Error fetching data from Firebase: $e');
      return null;
    }
  }

  //update profile method
  updateProfile(context) async {
    var store = FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    await store.set({
      'fullname': nameController.text,
      'numberphone': numberphoneController.text,
      'birthday': birthdayController.text,
      'image': imglink

    }, SetOptions(merge: true));
   
    VxToast.show(context, msg: "Profile updates successfully!");
  }

  //image picking method
  pickImage(context, source) async {
    await Permission.photos.request();
    await Permission.camera.request();
    var status = await Permission.photos.status;
    var camera = await Permission.camera.status;
    //handle status
    if (status.isGranted || camera.isGranted) {
      try {
        final img =
            await ImagePicker().pickImage(source: source, imageQuality: 80);
        imgpath.value = img!.path;
        VxToast.show(context, msg: "Image selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    } else {
      VxToast.show(context, msg: "Premisstion denied");
    }
  }

  //uploadImage
  uploadImage() async {
    var name = basename(imgpath.value);
    //Thiết lập đường dẫn đích của tệp trên Firestore
    var destination = 'images/${currentUser!.uid}/$name';
    //Thêm đường dẫn đích để tạo tệp
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    io.File file = io.File(
        imgpath.value); // Sử dụng tên bí danh 'io' để truy cập lớp 'File'
    await ref.putFile(file);
    // Lấy URL của tệp tải lên và lưu 
    var d = await ref.getDownloadURL();
    print(d);
    imglink = d;
  }
}

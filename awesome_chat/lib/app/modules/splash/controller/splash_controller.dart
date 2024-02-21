import 'package:awesome_chat/app/generated/widget_tree.dart';
import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController{
  SharedPreferences? prefs;
  @override
  void onInit() {
    super.onInit();
    requestPermission();
  }
  void initSharedPref() async {
    
    prefs = await SharedPreferences.getInstance();
    final loginData = prefs?.getString("loginData");
    if(loginData==null){
      Future.delayed(const Duration(seconds: 1), () {
       Get.offNamed(AppRouterName.WidgetTree);
      });
    }
    else{
      Future.delayed(const Duration(seconds: 1),(){
       // Get.offNamed(AppRouterName.NavigatorHome);
      });
    }
    //
  }
   Future<void> requestPermission() async {
    final status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      initSharedPref();
    } else {
      try {
        await Permission.storage.request();
        initSharedPref();
      } catch (e) {
        // Xử lý lỗi nếu cần
        print("Error requesting storage permission: $e");
      }
    }
  }

}
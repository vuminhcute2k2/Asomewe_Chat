import 'package:awesome_chat/app/modules/splash/controller/splash_controller.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController splashController = Get.put(SplashController());
  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration(seconds: 2), () {
    //   // Navigator.pushReplacement(
    //   //   context,
    //   //   MaterialPageRoute(builder: (context) =>const GetStartedScreen()),
    //   // );
    //   Get.offAndToNamed(AppRouterName.Continue);
    // });
    splashController.requestPermission();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient:AppColors.backgroundColorApp,
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/images/image_not_found.png',width: 100,height: 100,color: Colors.white,),
              SvgPicture.asset('assets/images/logo.svg'),
              Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text:const TextSpan(
                        style: TextStyle(fontSize: 40),
                        children: [
                          TextSpan(
                            text: "Awesome ",
                            style: TextStyle(
                              fontFamily: 'Exo'
                            ),
                          ),
                          TextSpan(
                            text: "chat",
                            //style: CustomTextStyles.displayMediumLight,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
            ],
          ),
        ),

      ),
      )
    );
  }
}
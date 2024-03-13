import 'package:awesome_chat/app/routers/app_routers.dart';
import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 40,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRouterName.NavigatorHome);
                      },
                      child: SvgPicture.asset('assets/images/img_arrow_left.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          
                        ),
                        child: Image.asset('assets/images/img_avt_random1.png',),
                      ),
                    ),
                    const Text('User name',style: TextStyle(fontSize: 18),),
                  ],
                ),
                Container(
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.green,
                  ),
                  child:const Padding(
                    padding:  EdgeInsets.all(6.0),
                    child:  Text('Hôm nay'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
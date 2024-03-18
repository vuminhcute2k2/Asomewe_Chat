import 'package:awesome_chat/themes/colors.dart';
import 'package:flutter/material.dart';

Widget ItemRequest() {
  return const  Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('LỜI MỜI KẾT BẠN',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,fontFamily: 'lato',color: AppColors.colorGrayText),),
          )
        ],
      ),
    ),
  );
}
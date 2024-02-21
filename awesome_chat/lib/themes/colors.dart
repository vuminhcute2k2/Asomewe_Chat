import 'package:flutter/material.dart';
class AppColors{
  static LinearGradient get backgroundColorApp => LinearGradient(
    begin:const Alignment(1.2, 0.1),
    end:const Alignment(0.5, 1),
    colors: [
      const Color(0xFF4356B4).withOpacity(0.95),
      const Color(0xFF3DCFCF).withOpacity(1),
    ],
  );
  static const colorGrayText = Color(0XFF999999);
  static const colorVioletText = Color(0XFF4356B4);
}
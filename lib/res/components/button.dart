import 'package:flutter/material.dart';

import '../colors.dart';
import '../constants/sizes.dart';
import '../styles/box_decoration.dart';

Widget button(VoidCallback func,String title,double height,double width){
  return GestureDetector(
    onTap: func,
    child: Container(
      height: height*Height.height_52,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: orange
      ),
      child: Center(child: Text(title,style: white_semibold_18,),),
    ),
  );
}

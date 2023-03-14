


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../styles/box_decoration.dart';

Widget textInput(TextEditingController controller, String placeholder,
    IconData icon, bool isHide, double width, TextInputType keyType,String validationText) {
  return TextFormField(
    controller: controller,
    // readOnly: isHide,
    style: outer_space_regular_16,
    keyboardType: keyType,
    obscureText: isHide,
    validator: (value){
      if(value == null || value.isEmpty){
        return validationText;
      }
      else{
        return null;
      }
    },
    decoration: InputDecoration(
      fillColor: bright_grey,
      filled: true,
      hintText: placeholder,
      hintStyle: dusty_grey_regular_16,
      prefixIcon: IconTheme(
        data: IconThemeData(
          color: controller.text.toString() == '' ? dusty_grey : outer_space,
          size: 16,
        ),
        child: Icon(icon),
      ),
      // icon: Image.asset(icon,width: width*Width.width_16,color: controller.text.toString() == ""? dusty_grey: outer_space,),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color:bright_grey,width: 1)
      ),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color:bright_grey,width: 1)
      ),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color:bright_grey,width: 1)
      ),
      errorBorder:  const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Colors.red,width: 1)
      ),

    ),
  );
}
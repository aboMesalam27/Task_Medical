import 'package:flutter/material.dart';

Widget buildButton({elevation,color,textColor,required text,required onPressed}){
  return RaisedButton(
    elevation: elevation,
    color: color,
    textColor:textColor,
    child:  SizedBox(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18.0, fontFamily: 'Brand Bold'),
        ),
      ),
    ),
    onPressed:onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
}
//constant
Color color1=const Color.fromRGBO(180, 236, 227,1);
Color color2= Colors.blue.shade700;
Color color3= Colors.grey.shade700;
Color color4= Colors.purple.shade900;
Color color5= Colors.blue.shade900;
Color grey= Colors.grey;
Color white=Colors.white;
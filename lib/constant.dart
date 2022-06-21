//......STRINGS.......//

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const baseURL = 'http://127.0.0.1:8000/api';
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const postURL = baseURL + '/empreendedora';
const commentURL = baseURL + '/notificacao';

//----------Errors------------//
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

//Input decoration
InputDecoration globalInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black),
    ),
  );
}

//Button

TextButton globalTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      padding: MaterialStateProperty.resolveWith(
        (states) => EdgeInsets.symmetric(vertical: 10),
      ),
    ),
    onPressed: () => onPressed(),
  );
}

//loginRegisterLink

Row glabalMessageLink(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(
          label,
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () => onTap(),
      ),
    ],
  );
}
//Colors

Color primaryColor = Color(0xffd1ad17);
Color scaffoldBackgroundColor = Color(0xffcbcbcb);
Color textColor = Colors.black87;

//Like and Comment

Expanded likeAndComment(int value, IconData icon,Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: ()=>onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 10,color: color,
              ),
              SizedBox(
                width: 4,
              ),
              Text('${value}'),
            ],
          ),
        ),
      ),
    ),
  );
}

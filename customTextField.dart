import 'package:flutter/material.dart';
import 'main.dart';

class CustomTextField extends StatelessWidget {
 // final double width;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String hintText;
  final int maxLength;
  final TextAlign textAlign;
  final IconData icon;

  const CustomTextField({
    required this.maxLength,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    //required this.width,
    required this.icon,
    this.textAlign = TextAlign.center,
  });

      @override
      Widget build(BuildContext context) {
        return Container(
          //width: width,
          child: TextFormField(
            textAlign: textAlign,
            controller: textEditingController,
            keyboardType: textInputType,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(
                icon,
                color: Colors.green
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        );
      }
    }
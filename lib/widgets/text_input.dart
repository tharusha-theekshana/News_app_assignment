import 'package:flutter/material.dart' hide Colors;

import '../utils/colors.dart';
import '../utils/styles.dart';


class TextInput extends StatelessWidget {

  final String title;
  final double width;
  final TextEditingController controller;
  final TextInputType type;
  final int inputLength;
  final bool obsText;

  const TextInput({required this.title,required this.width,required this.controller, required this.type,required this.inputLength,required this.obsText});

  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: RichText(
              text: TextSpan(
                text: title,
                style: Styles.inputFieldsTitle,
                children: <TextSpan>[
                  TextSpan(text: ' * ',style: TextStyle(
                      color: Colors.errorColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0
                  )),
                ],
              ),
            ),
          ),
          TextFormField(
            obscureText: obsText,
            cursorColor: Colors.gray,
            style: Styles.inputFieldsText,
            keyboardType: type,
            controller: controller,
            maxLength: inputLength,
            validator: (value) {
              if (value!.isEmpty) {
                return "";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              counterText: '',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal:12.0,vertical: 13.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1.5, color: Colors.grayLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 2, color: Colors.gray),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 2, color: Colors.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.errorColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

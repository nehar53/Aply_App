import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class TextFieldOtp extends StatelessWidget {
  TextFieldOtp({this.focusNodeP, this.focusNodeN, this.onChanged});

  final focusNodeP;
  final focusNodeN;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 4.5 * 10,
          height: 4.5 * 10,
          child: Container(
            width: 4.5 * 10,
            height: 4.5 * 10,
            child: Center(
              child: TextField(
                style: const TextStyle(color: Colors.black, fontSize: 15),
                cursorColor: Colors.black,
                autofocus: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  counter: Offstage(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlue),
                      borderRadius: BorderRadius.circular(12)),
                ),
                focusNode: focusNodeP,
                maxLength: 1,
                textAlign: TextAlign.center,
                onChanged: onChanged,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(focusNodeN);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

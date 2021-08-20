import 'package:flutter/material.dart';

void showSnackBar(String text, BuildContext context, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: color,
        content: Text(
          text,
        )),
  );
}

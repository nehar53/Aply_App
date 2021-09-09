import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;
  const CustomButton({Key key, this.icon, this.onClicked, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.deepOrange.shade500,
        minimumSize: Size.fromHeight(50),
      ),
      child: buildContent(),
      onPressed: onClicked,
    );
  }

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontFamily: 'Roboto'),
          )
        ],
      );
}

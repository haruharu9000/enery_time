import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    this.color = Colors.black87,
    this.backgroundColor = Colors.white,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: color),
        ),
        onPressed: onClicked,
      );
}

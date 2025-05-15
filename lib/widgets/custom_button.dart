import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text, this.onTap});

  String text;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 60,
        child: Center(
            child: Text(
          text,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
        )),
      ),
    );
  }
}

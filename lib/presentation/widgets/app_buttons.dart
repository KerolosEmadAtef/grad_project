import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainAppButtons extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final Color borderColor;
  final String text;
  double? widthSize;
  double? heightSize;
  dynamic icon;
  bool? isIcon;

  MainAppButtons({
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.borderColor,
    required this.text,
    this.widthSize = double.infinity,
    this.heightSize = 55,
    this.icon,
    this.isIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: heightSize,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon == true) // Conditionally display icon
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  icon
                      as String, // Assuming icon is a String (image asset path)
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                ),
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

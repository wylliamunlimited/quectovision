import 'package:flutter/material.dart';

class AnalyzeButton extends StatelessWidget {
  const AnalyzeButton({
    super.key,
    required this.onPress,
    this.width = 150,
    this.height = 50,
    this.backgroundColor = const Color.fromARGB(255, 1, 25, 5),
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
  });

  final Function() onPress;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: this.backgroundColor,
        ),
        onPressed: onPress,
        child: Text(
          "Analyze",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: this.textColor,
            shadows: [
              Shadow(
                blurRadius: 1.0,
                color: Colors.grey,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

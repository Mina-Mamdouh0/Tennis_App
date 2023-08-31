import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback? onPressed;
  final double height;
  final double width;

  const NoData({
    Key? key,
    required this.text,
    required this.buttonText,
    this.onPressed,
    this.height = 100,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0x440D5FC3),
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  final double height, width;
  final Color color;

  const CircularIndicator({
    super.key,
    this.height = 20,
    this.width = 20,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
      ),
    );
  }
}

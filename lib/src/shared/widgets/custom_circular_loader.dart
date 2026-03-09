import 'package:flutter/material.dart';

class CustomCircularLoader extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const CustomCircularLoader({
    super.key,
    this.size = 40.0,
    this.color,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }
}

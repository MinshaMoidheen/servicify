import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double? height;
  double? width;
  String? text;
  Color? color;
  final Widget? child;
  final VoidCallback? onTap;

  CustomButton(
      {Key? key,
        this.text,
        this.height,
        this.width,
        required this.onTap,
        this.color,
        required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color
        ),
        child: Center(child: child),
      ),
    );
  }
}

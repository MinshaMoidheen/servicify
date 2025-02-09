
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String? data;
  double? size;
  Color? color;
  FontWeight? fontWeight;

  CustomText({
    Key? key,
    required this.data,
    this.size,
    this.color,
    this.fontWeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data.toString(),
      style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight
      ),
    );
  }
}

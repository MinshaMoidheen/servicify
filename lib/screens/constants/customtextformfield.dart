import 'package:flutter/material.dart';
class CustomTextFormField extends StatefulWidget {


  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;




  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.obscureText = false,

    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.enabledBorder,
    this.focusedBorder
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText=true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          decoration: InputDecoration(

            hintText: widget.hintText,
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            errorBorder: OutlineInputBorder(),
            prefixIcon:widget.prefixIcon,
            suffixIcon: widget.obscureText ? IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ) : widget.suffixIcon,

          ),
          validator:widget.validator

      ),
    );
  }
}




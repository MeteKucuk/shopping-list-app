import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscureTextt;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const CustomTextFormField(
      {Key? key,
      required this.hintText,
      required this.obscureTextt,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

bool isobscureText = false;

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: FocusNode(),
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureTextt ? isobscureText : false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        suffixIcon: widget.obscureTextt
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isobscureText = !isobscureText;
                  });
                },
                child: Icon(
                  isobscureText ? Icons.visibility_off : Icons.visibility,
                ))
            : null,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

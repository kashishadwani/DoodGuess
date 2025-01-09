import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController Controller;
  final String hintText;
  CustomTextField({Key? key,required this.Controller, required this.hintText}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: const Color(0xffF5F5FA),
        hintText: "Enter your Name",
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        )
      ),
    );
  }
}

//Custom TextField Clss.......
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx1/controllors/basic_controllors.dart';

import 'constants/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.size,
    required this.hint,
    this.keyboardType,
    required this.controller,
    this.onchange,
    this.validator,
    this.type = true,
  });

  final Size size;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final void Function(String)? onchange;
  final String? Function(String?)? validator;
  final bool type;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          cursorColor: customBalck,
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onchange,
          validator: validator,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: size.height * 0.015,
                  horizontal: size.width * 0.03)),
        ),
        type
            ? Consumer<BasicControllors>(builder: (context, data, child) {
                return Positioned(
                  left: size.width * 0.34,
                  top: size.height * 0.01,
                  child: data.state
                      ? const SizedBox()
                      : const Text(
                          '*',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                );
              })
            : const SizedBox()
      ],
    );
  }
}

class CustomTextfield1 extends StatelessWidget {
  const CustomTextfield1({
    super.key,
    required this.size,
    required this.hint,
    this.keyboardType,
    required this.controller,
    this.onchange,
    this.validator,
  });

  final Size size;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final void Function(String)? onchange;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: customBalck,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onchange,
      validator: validator,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400),
          filled: true,
          fillColor: white,
          prefixIcon: const Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey)),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.height * 0.015, horizontal: size.width * 0.03)),
    );
  }
}

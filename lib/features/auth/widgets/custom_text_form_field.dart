import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData? icon;
  final String labelText;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final bool obscureText;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.icon,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onTap: () {
        if (controller != null) {
          controller!.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller!.text.length,
          );
        }
      },
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        letterSpacing: 0.6,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 8,
        ),
        prefixIcon: icon != null
            ? Icon(icon, size: 32)
            : null,
        prefixIconColor: Colors.black87,
        prefixIconConstraints: BoxConstraints(
          minHeight: 40,
          minWidth: 40,
        ),
        // icon: icon != null
        //     ? Container(
        //         height: 45,
        //         width: 45,
        //         alignment: Alignment.center,
        //         padding: const EdgeInsets.all(6),
        //         decoration: BoxDecoration(
        //           color: Colors.grey,
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //         child: Center(
        //           child: Icon(
        //             icon,
        //             color: Colors.black87,
        //             size: 30,
        //           ),
        //         ),
        //       )
        //     : null,
        iconColor: Colors.black87,
        labelText: labelText,
        floatingLabelStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        labelStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
          fontSize: 15,
        ),
        errorText: errorText,
        filled: true,
        fillColor: Colors.white70,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black87,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black87,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

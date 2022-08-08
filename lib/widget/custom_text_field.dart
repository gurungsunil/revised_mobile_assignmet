import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revised_mobile_assignment/constant/style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final String hintText;
  final bool? obscureText;
  final bool? enabled;
  final bool? readOnly;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatter;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.validator,
    this.textInputType,
    String? hintText,
    this.obscureText,
    this.enabled,
    this.errorText,
    this.onChanged,
    this.inputFormatter,
    this.onTap,
    this.readOnly,
  })  : hintText = hintText ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: TextFormField(
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        keyboardType: textInputType,
        inputFormatters: inputFormatter,
        onChanged: onChanged,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: TEXT_COLOR,
          fontSize: 14,
        ),
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          enabled: enabled ?? true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: TEXT_COLOR2,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          errorText: errorText,
          counterText: "",
          errorMaxLines: 2,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

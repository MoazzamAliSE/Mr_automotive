import 'package:auto_motive/res/app_color.dart';
import 'package:flutter/material.dart';

class GenericTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final String? value;

  final FormFieldValidator<String>? validator;
  final Color? borderColor;
  final Color? cursorColor;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  const GenericTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.labelStyle = const TextStyle(color: whiteColor),
    this.style =
        const TextStyle(color: whiteColor, decorationColor: whiteColor),
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.value,
    this.borderColor,
    this.cursorColor = whiteColor,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        cursorColor: cursorColor,
        onChanged: onChanged,
        style: style,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle,
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: borderColor ?? whiteColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: borderColor ?? whiteColor, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: whiteColor, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: redColor, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: redColor, width: 2.0),
          ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onSaved: onSaved,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
      ),
    );
  }
}

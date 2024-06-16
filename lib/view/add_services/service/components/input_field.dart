import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.hint,
    required this.controller,
    required this.icon,
    this.onChanged,
    required this.title,
    this.color,
    this.type,
    this.readOnly,
  });
  final String hint;
  final String title;
  final Color? color;
  final TextInputType? type;
  final TextEditingController controller;
  final Widget icon;
  final bool? readOnly;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          const SizedBox(
            height: 20,
          ),
        if (title.isNotEmpty)
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        if (title.isNotEmpty)
          const SizedBox(
            height: 5,
          ),
        SizedBox(
          height: 45,
          child: TextFormField(
            readOnly: readOnly ?? false,
            controller: controller,
            keyboardType: type,
            onChanged: onChanged,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            validator: (value) {
              if (value == null) {
                return 'This field is required';
              } else if (value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  TextStyle(color: color ?? Colors.white12, fontSize: 12),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hoverColor: Colors.white,
              prefixIcon: icon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: color ?? Colors.white12,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

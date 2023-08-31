import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  bool autofocus = false, // Add this parameter with a default value of false
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        autofocus: autofocus, // Set the autofocus property

        onFieldSubmitted: (value) {},
        onChanged: (value) {
          return onChange!(value);
        },
        onTap: () {
          onTap!();
        },
        validator: (value) {
          return validate(value);
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: label,
          prefixIcon: prefix != null ? Icon(prefix) : null,
          hintStyle: const TextStyle(
            color: Color(0xFFA8A8A8),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 15), // Remove the padding

          filled: true, // Enable background fill
          fillColor: Colors.white, // Set the background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

class InputTextWithHint extends StatelessWidget {
  final String text;
  final String hint;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final TextInputType? type;

  const InputTextWithHint({
    Key? key,
    required this.text,
    required this.hint,
    this.type,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * .83,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 2),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF525252),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          defaultFormField(
            controller: controller,
            type: type, // Replace with the desired input type
            onSubmit: null,
            onChange: null,
            onTap: null, autofocus: false, // Set autofocus to false

            isPassword: false,
            validate: (value) {
              if (value!.isEmpty) {
                return 'Please this field is required';
              }
              return null;
            },
            label: hint, // Use the hint as the label
            suffix: suffixIcon,
            prefix: prefixIcon,
            suffixPressed: null,
            isClickable: true,
          ),
        ],
      ),
    );
  }
}

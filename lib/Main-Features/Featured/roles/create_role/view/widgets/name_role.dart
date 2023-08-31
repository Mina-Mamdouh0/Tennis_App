import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextFormField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 2),
          child: Text(
            S.of(context).Create_Role,
            style: const TextStyle(
              color: Color(0xFF525252),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0x300A557F), width: 1),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none, // Remove the line
              ),
              hintText: S.of(context).Describe_Role_type_here,
              hintStyle: const TextStyle(
                color: Color(0xFFA8A8A8),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class InputDateField extends StatelessWidget {
  final String text;
  final String hint;

  const InputDateField({
    Key? key,
    required this.text,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, left: screenWidth * .055),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF525252),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            width: screenWidth * .8,
            height: screenHeight * .05,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0x300A557F)),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: const TextStyle(
                    color: Color(0xFFA8A8A8),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_outlined),
                    onPressed: () {},
                  ),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).Please_enter_a_valid_date;
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

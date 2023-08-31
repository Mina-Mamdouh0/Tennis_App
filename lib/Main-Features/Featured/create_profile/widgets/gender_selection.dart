import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../cubits/Gender_Cubit.dart';

class GenderSelection extends StatelessWidget {
  const GenderSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<GenderCubit, String>(
      builder: (context, selectedGender) {
        return Container(
          width: screenWidth * 0.6,
          height: screenHeight * 0.06,
          decoration: ShapeDecoration(
            color: Color(0x1EFFA372),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * .045,
                child: _buildGenderButton(
                    context, S.of(context).male, selectedGender),
              ),
              SizedBox(width: screenWidth * 0.05),
              SizedBox(
                height: screenHeight * .045,
                child: _buildGenderButton(
                    context, S.of(context).female, selectedGender),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenderButton(
    BuildContext context,
    String gender,
    String selectedGender,
  ) {
    final isSelected = selectedGender == gender;
    final genderCubit = context.read<GenderCubit>();

    return GestureDetector(
      onTap: () {
        genderCubit.selectGender(gender);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.035,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : null,
          borderRadius: BorderRadius.circular(50),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: isSelected ? 18 : 15,
              fontWeight: FontWeight.w500,
              color: isSelected ? Color(0xFF00344E) : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}

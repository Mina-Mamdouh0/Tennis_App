import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/Featured/roles/roles_list/view/widgets/list_roles.dart';
import 'package:tennis_app/core/utils/widgets/custom_button.dart';
import 'package:tennis_app/core/utils/widgets/pop_app_bar.dart';

import '../../../../../core/utils/widgets/app_bar_wave.dart';
import '../../../../../generated/l10n.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: const Color(0xFFF8F8F8),
        height: screenHeight,
        child: Column(children: [
          PoPAppBarWave(
            prefixIcon: IconButton(
              onPressed: () {
                GoRouter.of(context).replace('/menu');
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
            text: S.of(context).Roles,
            suffixIconPath: '',
          ),
          Text(
            S.of(context).Roles_list,
            style: TextStyle(
              color: Color(0xFF616161),
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          ListRoles(),
          GestureDetector(
            onTap: () => GoRouter.of(context).push('/assignPerson'),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: screenWidth * 0.4,
                height: 50,
                decoration: ShapeDecoration(
                  color: const Color(0x30FFA372),
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFF00344E)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).Assign_Roles_to_a_Person,
                    style: TextStyle(
                      color: Color(0xFF00344E),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          BottomSheetContainer(
            buttonText: S.of(context).Create_Role,
            onPressed: () {
              GoRouter.of(context).push('/createRole');
            },
          )
        ]),
      ),
    );
  }
}

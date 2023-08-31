import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/menu/widgets/button_menu.dart';

import '../../Auth/services/auth_methods.dart';
import '../../core/methodes/firebase_methodes.dart';
import '../../core/utils/widgets/app_bar_wave.dart';
import '../../generated/l10n.dart';
import '../../models/player.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final Method method = Method();

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<Player>(
          future: method.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final player = snapshot.data!;

              return Container(
                color: const Color(0xFFF8F8F8),
                child: Column(
                  children: [
                    AppBarWaveHome(
                      text: S.of(context).Menu,
                      suffixIconPath: 'assets/images/app-bar-icon.svg',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: screenHeight * 0.13,
                      width: screenHeight * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey, // Customize the border color here
                          width: 2.0, // Customize the border width here
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: (player.photoURL != ''
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loadin.gif',
                                image: player.photoURL!,
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  // Show the placeholder image on error
                                  return Image.asset(
                                    'assets/images/profileimage.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/profile-event.jpg',
                                fit: BoxFit.cover,
                              )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/setting1.svg',
                      buttonText: S.of(context).Your_Profile,
                      onPressed: () {
                        GoRouter.of(context).push('/profileScreen');
                      },
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/Event-Calnder.svg',
                      buttonText: S.of(context).Event_Calendar,
                      onPressed: () {
                        GoRouter.of(context).push('/calendar');
                      },
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/Member-administration.svg',
                      buttonText: S.of(context).Member_administration,
                      onPressed: () {
                        GoRouter.of(context).push('/management');
                      },
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/Create-role.svg',
                      buttonText: S.of(context).Create_Role,
                      onPressed: () {
                        GoRouter.of(context).push('/createRole');
                      },
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/Create-role.svg',
                      buttonText: S.of(context).Assign_Person,
                      onPressed: () {
                        GoRouter.of(context).push('/assignPerson');
                      },
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/Create-role.svg',
                      buttonText: S.of(context).Roles_list,
                      onPressed: () {
                        GoRouter.of(context).push('/rolesList');
                      },
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/languages.svg',
                      buttonText: 'Language',
                      onPressed: () {
                        GoRouter.of(context).push('/languages');
                      },
                    ),
                    ButtonMenu(
                      imagePath: 'assets/images/logout.svg',
                      buttonText: S.of(context).logout,
                      onPressed: () async {
                        final FirebaseAuthMethods _authService =
                            FirebaseAuthMethods();

                        await _authService.signOut();
                        GoRouter.of(context).go('/auth');
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Auth/screens/auth_screen.dart';
import 'package:tennis_app/Main-Features/Featured/create_court/view/create_court_screen.dart';
import 'package:tennis_app/Main-Features/Featured/create_profile/create_profile_screen.dart';
import 'package:tennis_app/Main-Features/Featured/edit_screen/edit_profile_screen.dart';
import 'package:tennis_app/Main-Features/Featured/navigation_bar/cubit/navigation_cubit.dart';
import 'package:tennis_app/Main-Features/Featured/navigation_bar/navigation_bar_screen.dart';
import 'package:tennis_app/Main-Features/Featured/onboarding/onboarding_screen.dart';
import 'package:tennis_app/Main-Features/Featured/roles/roles_list/view/widgets/list_roles.dart';
import 'package:tennis_app/Main-Features/Featured/set_reminder/set_reminder_screen.dart';
import 'package:tennis_app/Main-Features/Featured/splash/splash_screen.dart';
import 'package:tennis_app/Main-Features/chats/screens/player_search_screen.dart';
import 'package:tennis_app/Main-Features/chats/screens/user_groups_screen.dart';
import 'package:tennis_app/Main-Features/menu/menu_screen.dart';
import 'package:tennis_app/Main-Features/create_event_match/create_event_match_screen.dart';
import '../../Auth/screens/forget_password.dart';
import '../../Main-Features/Featured/choose_club/choose_club_screen.dart';
import '../../Main-Features/Featured/club_managment/view/managment_screen.dart';
import '../../Main-Features/Featured/create_club/view/create_club.dart';
import '../../Main-Features/Featured/create_court/view/court_search.dart';
import '../../Main-Features/Featured/create_event/view/create_event.dart';
import '../../Main-Features/Featured/event_calender/event_calender_screen.dart';
import '../../Main-Features/Featured/find_match/view/find_match_screen.dart';
import '../../Main-Features/Featured/localization/choose_language.dart';
import '../../Main-Features/Featured/profile/view/profile_screen.dart';
import '../../Main-Features/Featured/roles/assign_person/view/assign_person_screen.dart';
import '../../Main-Features/Featured/roles/create_role/view/create_role_screen.dart';
import '../../Main-Features/Featured/roles/roles_list/view/roles_list_screen.dart';

import '../../Main-Features/chats/screens/create_group.dart';
import '../../Main-Features/chats/screens/groups_screen.dart';
import '../../Main-Features/create_event_match/double_friendly_match/double_match_screen.dart';
import '../../Main-Features/create_event_match/double_tournment/double_tournment_screen.dart';
import '../../Main-Features/create_event_match/single_friendly_match/single_match_screen.dart';
import '../../Main-Features/create_event_match/single_tournment/single_tournment_screen.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: SplashScreen(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => NavigationCubit(),
                child: const NavigationBarScreen(),
              );
            },
          ),
          GoRoute(
            path: 'onboarding',
            builder: (BuildContext context, GoRouterState state) {
              return const Onboarding();
            },
          ),
          GoRoute(
            path: 'languages',
            builder: (BuildContext context, GoRouterState state) {
              return const ChooseLanguage();
            },
          ),
          GoRoute(
            path: 'auth',
            builder: (BuildContext context, GoRouterState state) {
              return const AuthScreen();
            },
          ),
          GoRoute(
            path: 'forgetPassword',
            builder: (BuildContext context, GoRouterState state) {
              return const ForgetPassword();
            },
          ),
          GoRoute(
            path: 'chooseClub',
            builder: (BuildContext context, GoRouterState state) {
              return ClubInvitationsPage();
            },
          ),
          GoRoute(
            path: 'createProfile',
            builder: (BuildContext context, GoRouterState state) {
              return CreateProfile();
            },
          ),
          GoRoute(
            path: 'editProfile',
            builder: (BuildContext context, GoRouterState state) {
              return EditProfile();
            },
          ),
          GoRoute(
            path: 'createClub',
            builder: (BuildContext context, GoRouterState state) {
              return CreateClub();
            },
          ),
          GoRoute(
            path: 'createEvent',
            builder: (BuildContext context, GoRouterState state) {
              return CreateEvent();
            },
          ),
          GoRoute(
            path: 'menu',
            builder: (BuildContext context, GoRouterState state) {
              return const MenuScreen();
            },
          ),
          GoRoute(
            path: 'createRole',
            builder: (BuildContext context, GoRouterState state) {
              return const CreateRole();
            },
          ),
          GoRoute(
            path: 'assignPerson',
            builder: (BuildContext context, GoRouterState state) {
              return AssignPerson();
            },
          ),
          GoRoute(
            path: 'rolesList',
            builder: (BuildContext context, GoRouterState state) {
              return const RolesScreen();
            },
          ),
          GoRoute(
            path: 'findPartner',
            builder: (BuildContext context, GoRouterState state) {
              return FindMatch();
            },
          ),
          GoRoute(
            path: 'findCourt',
            builder: (BuildContext context, GoRouterState state) {
              return const CourtSearchScreen();
            },
          ),
          GoRoute(
            path: 'createCourt',
            builder: (BuildContext context, GoRouterState state) {
              return CreateCourt();
            },
          ),
          GoRoute(
            path: 'management',
            builder: (BuildContext context, GoRouterState state) {
              return ManagementScreen();
            },
          ),
          GoRoute(
            path: 'calendar',
            builder: (BuildContext context, GoRouterState state) {
              return CalendarScreen();
            },
          ),
          GoRoute(
            path: 'searchChat',
            builder: (BuildContext context, GoRouterState state) {
              return PlayerSearchScreen();
            },
          ),
          GoRoute(
            path: 'profileScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
          GoRoute(
            path: 'singleMatches',
            builder: (BuildContext context, GoRouterState state) {
              return const SingleMatchScreen();
            },
          ),
          GoRoute(
            path: 'doubleMatches',
            builder: (BuildContext context, GoRouterState state) {
              return const DoubleMatchScreen();
            },
          ),
          GoRoute(
            path: 'singleTournament',
            builder: (BuildContext context, GoRouterState state) {
              return const SingleTournamentScreen();
            },
          ),
          GoRoute(
            path: 'doubleTournament',
            builder: (BuildContext context, GoRouterState state) {
              return const DoubleTournamentScreen();
            },
          ),
          GoRoute(
            path: 'createMatch',
            builder: (BuildContext context, GoRouterState state) {
              return const CreateEventMatchesScreen();
            },
          ),
          GoRoute(
            path: 'createGroup',
            builder: (BuildContext context, GoRouterState state) {
              return const CreateGroup();
            },
          ),
        ],
      ),
    ],
  );
}

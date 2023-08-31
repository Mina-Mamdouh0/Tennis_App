import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Main-Features/Featured/navigation_bar/widgets/navigation_bar_item.dart';
import '../../chats/chat_screen.dart';
import '../../club/club_screen.dart';
import '../../home/home_screen.dart';
import '../../menu/menu_screen.dart';
import 'cubit/navigation_cubit.dart';

class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _getPageByIndex(state),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: state,
            height: 60.0,
            items: const [
              NavigationBarItem(
                icon: Icons.home_outlined,
                label: 'Home',
                index: 0,
              ),
              NavigationBarItem(
                icon: Icons.sports_tennis,
                label: 'Club',
                index: 1,
              ),
              NavigationBarItem(
                icon: Icons.messenger_outline_outlined,
                label: 'Chat',
                index: 2,
              ),
              NavigationBarItem(
                icon: Icons.menu,
                label: 'Menu',
                index: 3,
              ),
            ],
            color: Colors.white,
            buttonBackgroundColor: Color(0xFF15324F),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 400),
            onTap: (index) {
              final navigationCubit = context.read<NavigationCubit>();
              navigationCubit.selectPage(index);
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }

  Widget _getPageByIndex(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ClubScreen();
      case 2:
        return const ChatScreen();
      case 3:
        return const MenuScreen();
      default:
        return Container();
    }
  }
}

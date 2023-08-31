import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/Auth/screens/tab_bar_pages/sign_in.dart';
import 'package:tennis_app/Auth/screens/tab_bar_pages/sign_up.dart';
import 'package:tennis_app/Auth/widgets/waveClipperScreen.dart';
import 'package:tennis_app/Main-Features/chats/screens/chats_screen.dart';
import 'package:tennis_app/Main-Features/chats/screens/user_groups_screen.dart';
import 'package:tennis_app/core/utils/widgets/opacity_wave.dart';
import 'package:tennis_app/generated/l10n.dart';

class GroupPrivateChats extends StatefulWidget {
  const GroupPrivateChats({Key? key}) : super(key: key);

  @override
  State<GroupPrivateChats> createState() => _GroupPrivateChatsState();
}

class _GroupPrivateChatsState extends State<GroupPrivateChats>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: screenWidth * .7,
            decoration: ShapeDecoration(
              color: const Color.fromARGB(179, 255, 247, 240),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              shadows: const [
                BoxShadow(
                  color: Color.fromARGB(32, 0, 0, 0),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                tabBarTheme: const TabBarTheme(
                  labelColor: Color(0xFF0F4C81), // Customize selected tab color
                  unselectedLabelColor:
                      Color(0xFF6F6F6F), // Customize default tab color
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5),
                child: TabBar(
                  physics: const BouncingScrollPhysics(),
                  controller: tabController,
                  tabs: [
                    Tab(
                      text: "Private",
                    ),
                    Tab(
                      text: "Groups",
                    ),
                  ],
                  indicator: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ), // Customize the indicator color
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: const [PrivateChats(), UserGroupsScreen()],
          ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TabBarWithIndicator extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  TabBarWithIndicator({
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * .83,
      decoration: ShapeDecoration(
        color: const Color(0x5400344E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        shadows: const [
          BoxShadow(
            color: Color.fromARGB(32, 0, 0, 0),
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          tabBarTheme: const TabBarTheme(
            labelColor: Color(0xFF0F4C81),
            unselectedLabelColor: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5),
          child: TabBar(
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
            indicator: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
    );
  }
}

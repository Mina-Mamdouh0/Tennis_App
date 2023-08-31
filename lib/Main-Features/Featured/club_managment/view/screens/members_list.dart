import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/player.dart';
import '../widgets/member_item.dart';

class HorizontalListView extends StatefulWidget {
  final List<Player> memberNames;

  HorizontalListView({required this.memberNames});

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Visibility(
          visible: widget.memberNames.isNotEmpty,
          replacement: Center(
            child: Text(
              S.of(context).You_dont_have_any_members,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ), // Show only if there are members
          child: Container(
            height: screenHeight * 0.3, // Adjust the height as needed
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.memberNames.length,
              itemBuilder: (context, index) {
                final Player member =
                    widget.memberNames[index]; // Get the correct Player object
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MemberItem(
                    member: member,
                  ), // Pass the Player object to MemberItem
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        buildPageIndicator(widget.memberNames.length),
      ],
    );
  }

  Widget buildPageIndicator(int itemCount) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final bool isSelected = _currentPage == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: isSelected ? 11 : 9,
            height: isSelected ? 11 : 9,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.011),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

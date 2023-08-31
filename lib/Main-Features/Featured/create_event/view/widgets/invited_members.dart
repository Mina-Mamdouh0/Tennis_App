import 'package:flutter/material.dart';
import 'package:tennis_app/Main-Features/Featured/create_event/view/widgets/player_search_match.dart';

class MemberInvites extends StatefulWidget {
  final List<String> playerIds;

  MemberInvites({
    Key? key,
    required this.playerIds,
  }) : super(key: key);

  @override
  _MemberInvitesState createState() => _MemberInvitesState();
}

class _MemberInvitesState extends State<MemberInvites> {
  List<Color> wordColors = [
    const Color(0x5172B8FF),
    const Color(0x51EE746C),
    const Color(0x51FFA372),
  ];
  List<String> playerNames = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0x300A557F), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            LayoutBuilder(builder: (context, constraints) {
              final containerHeight = playerNames.isNotEmpty ? null : 50.0;
              return Container(
                height: containerHeight,
                padding: const EdgeInsets.only(
                    left: 8.0, top: 4, bottom: 4, right: 35),
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: playerNames.map<Widget>((String name) {
                    return Container(
                      decoration: ShapeDecoration(
                        color: wordColors[
                            playerNames.indexOf(name) % wordColors.length],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(name),
                    );
                  }).toList(),
                ),
              );
            }),
            Positioned(
              right: 8,
              child: IconButton(
                onPressed: () async {
                  final updatedNames = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerSearchInvite(
                        playerNames: playerNames,
                        playerIds: widget.playerIds,
                      ),
                    ),
                  );

                  if (updatedNames != null) {
                    setState(() {
                      playerNames = updatedNames;
                    });
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

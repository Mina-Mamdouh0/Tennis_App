import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';

class RightSelector extends StatefulWidget {
  final List<String> selectedWords;
  final List<String> words;
  final Function(List<String>) onSelectedWordsChanged;

  const RightSelector({
    Key? key,
    required this.selectedWords,
    required this.onSelectedWordsChanged,
    required this.words,
  }) : super(key: key);

  @override
  _RightSelectorState createState() => _RightSelectorState();
}

class _RightSelectorState extends State<RightSelector> {
  List<Color> wordColors = [
    const Color(0x5172B8FF),
    const Color(0x51EE746C),
    const Color(0x51FFA372),
  ];

  bool isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 2.0, left: screenWidth * .055),
          child: Text(
            S.of(context).Rights,
            style: const TextStyle(
              color: Color(0xFF525252),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final containerHeight =
                      widget.selectedWords.isNotEmpty ? null : 50.0;

                  return Container(
                    width: double.infinity,
                    height: containerHeight,
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 4, bottom: 4, right: 35),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: const Color(0x300A557F), width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 4,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: widget.selectedWords.map<Widget>((String word) {
                        return Container(
                          decoration: ShapeDecoration(
                            color: wordColors[
                                widget.selectedWords.indexOf(word) %
                                    wordColors.length],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(word),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: null,
                    onChanged: (String? newValue) {
                      print("HI" + widget.selectedWords.toString());
                      setState(() {
                        if (newValue != null) {
                          if (widget.selectedWords.contains(newValue)) {
                            widget.selectedWords.remove(newValue);
                          } else {
                            widget.selectedWords.add(newValue);
                          }
                          widget.onSelectedWordsChanged(widget.selectedWords);
                        }
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF1B262C),
                      size: 30,
                    ),
                    items: widget.words
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

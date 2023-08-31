import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

class DayCarousel extends StatelessWidget {
  final CarouselController carouselController;
  final int selectedDay;
  final Function(int) onDayTap;

  DayCarousel({
    required this.carouselController,
    required this.selectedDay,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          height: 100.0,
          initialPage: selectedDay - 1,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.25,
          aspectRatio: 10,
        ),
        items: List.generate(31, (index) {
          DateTime date = DateTime.now()
              .subtract(Duration(days: DateTime.now().day - 1))
              .add(Duration(days: index));
          String formattedWeek = DateFormat('EEE').format(date);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => onDayTap(index),
              child: Container(
                width: screenWidth * .2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: date.day == selectedDay ? Colors.blue : Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      child: Container(
                        height: 17,
                        color: date.day == selectedDay
                            ? const Color(0xFF00344E)
                            : const Color(0x5400344E),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        formattedWeek,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

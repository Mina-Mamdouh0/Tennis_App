import 'package:flutter/material.dart';

class PlayerStrength extends StatelessWidget {
  final double value;

  const PlayerStrength({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SliderTheme(
            data: SliderThemeData(
              thumbColor: const Color(0xFF1B262C),
              overlayColor: Colors.black.withOpacity(0.3),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              trackHeight: 8.0,
              activeTrackColor: _getSliderTrackColor(value),
              inactiveTrackColor: Colors.grey[300],
            ),
            child: Slider(
              value: value,
              min: 1.0,
              max: 10.0,
              divisions: 9,
              onChanged: (newValue) {
                // You can use this onChanged callback to update the parent widget's state if necessary.
              },
              label: value.round().toString(),
              onChangeEnd: (newValue) {
                // You can use this onChangeEnd callback to perform actions after the slider value changes.
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 8, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 1; i <= 10; i++)
                  Text(
                    i.toString(),
                    style: TextStyle(
                      color: i == value.round() ? Colors.black : Colors.grey,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getSliderTrackColor(double value) {
    final double fraction = (value - 1) / (10 - 1);
    return Color.lerp(Colors.white, Colors.red, fraction)!;
  }
}

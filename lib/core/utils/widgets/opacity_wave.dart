import 'package:flutter/material.dart';

import 'clipper.dart';

class OpacityWave extends StatelessWidget {
  const OpacityWave({super.key, required this.height});
  final height;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        decoration: const BoxDecoration(),
        child: ClipPath(
          clipper: WaveClipper(),
          child: Container(
            color: Colors.black,
            height: height,
          ),
        ),
      ),
    );
  }
}

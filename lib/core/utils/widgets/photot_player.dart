import 'package:flutter/material.dart';

class PhotoPlayer extends StatelessWidget {
  final String url;

  const PhotoPlayer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenHeight * 0.065,
      height: screenHeight * 0.065,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        // ignore: unnecessary_null_comparison
        child: (url != null
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/images/loadin.gif',
                image: url,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/profile-event.jpg',
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                'assets/images/internet.png',
                fit: BoxFit.cover,
              )),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final String imageAsset;

  const OnboardingBackground({super.key, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

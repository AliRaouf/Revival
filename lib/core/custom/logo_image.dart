import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LogoImage extends StatelessWidget {
  final Animation<double> logoAnimation;
  final double cardWidth;
  const LogoImage({
    super.key,
    required this.cardWidth,
    required this.logoAnimation,
  });
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
          scale: logoAnimation,
          child: Image.network(
            'https://revival-me.com/new2/wp-content/uploads/2020/05/Revival-transparent.png',
            width: cardWidth * 0.45,
            fit: BoxFit.contain,
          ),
        )
        .animate()
        .fade(duration: 800.ms)
        .scale(duration: 600.ms, curve: Curves.easeInOut);
  }
}

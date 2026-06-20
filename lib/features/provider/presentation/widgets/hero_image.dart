import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256,
      child: Stack(
        children: [
          // Background image placeholder
          Container(
            height: 256,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF0D47A1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Back button
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFAF8FF).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(9999),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: Color(0xFF191B23),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

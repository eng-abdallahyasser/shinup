import 'package:flutter/material.dart';
import 'package:shinup/features/onboarding/data/models/onboarding_model.dart';

class OnboardingStep extends StatelessWidget {
  final OnboardingData data;

  const OnboardingStep({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Illustrative Image Section ────────────────────────────────
          SizedBox(
            width: 350,
            height: 350,
            child: Stack(
              children: [
                // Image container
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDF9),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      data.imageAsset,
                      width: 350,
                      height: 350,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),

                // Top-right badge
                if (data.badgeText != null && !data.badgeHighlight)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: _buildBadge(
                      text: data.badgeText!,
                      bgColor: const Color(0xFF004AC6),
                      textColor: Colors.white,
                    ),
                  ),

                // Bottom-left highlight badge
                if (data.badgeText != null && data.badgeHighlight)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: _buildBadge(
                      text: data.badgeText!,
                      bgColor: const Color(0xFF6BFF8F),
                      textColor: const Color(0xFF007432),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Text Content ──────────────────────────────────────────────
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                height: 1.62,
                color: Color(0xFF434655),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: textColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shineup/core/localization/app_localizations.dart';

// ═════════════════════════════════════════════════════════════════════════════
//  Reviews Content
// ═════════════════════════════════════════════════════════════════════════════

class ReviewsContent extends StatelessWidget {
  const ReviewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Heading ───────────────────────────────────────────
          Text(
            AppLocalizations.of(context).providerReviewsTitle,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF191B23),
            ),
          ),
          SizedBox(height: 16),
          // ── Rating Summary Card ───────────────────────────────
          RatingSummaryCard(),
          SizedBox(height: 24),
          // ── Review Cards ──────────────────────────────────────
          ReviewCard(
            initials: 'A',
            avatarColor: Color(0xFF2563EB),
            initialColor: Color(0xFFEEEFFF),
            name: 'Alex M.',
            date: '2 days ago',
            rating: 5,
            text:
                'Great service! They were very professional with the express wash and even gave tips on battery maintenance.',
          ),
          SizedBox(height: 16),
          ReviewCard(
            initials: 'J',
            avatarColor: Color(0xFFFFDBCD),
            initialColor: Color(0xFF360F00),
            name: 'Jamie L.',
            date: '1 week ago',
            rating: 4,
            text:
                'The full detailing made my car look brand new. A bit of a wait but definitely worth it.',
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Rating Summary Card
// ═════════════════════════════════════════════════════════════════════════════

class RatingSummaryCard extends StatelessWidget {
  const RatingSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3FE),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          RatingBar(label: AppLocalizations.of(context).providerRatingExcellent, value: '95%', fill: 0.95),
          SizedBox(height: 8),
          RatingBar(label: AppLocalizations.of(context).providerRatingGood, value: '90%', fill: 0.90),
          SizedBox(height: 8),
          RatingBar(label: AppLocalizations.of(context).providerRatingAverage, value: '84%', fill: 0.84),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Rating Bar
// ═════════════════════════════════════════════════════════════════════════════

class RatingBar extends StatelessWidget {
  final String label;
  final String value;
  final double fill;

  const RatingBar({
    super.key,
    required this.label,
    required this.value,
    required this.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 20 / 14,
                color: Color(0xFF191B23),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                height: 20 / 14,
                color: Color(0xFF191B23),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Bar track
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: SizedBox(
            height: 6,
            width: double.infinity,
            child: Stack(
              children: [
                // Background track
                Container(
                  color: const Color(0xFFE1E2ED),
                ),
                // Filled portion
                FractionallySizedBox(
                  widthFactor: fill,
                  child: Container(
                    color: const Color(0xFF004AC6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Review Card
// ═════════════════════════════════════════════════════════════════════════════

class ReviewCard extends StatelessWidget {
  final String initials;
  final Color avatarColor;
  final Color initialColor;
  final String name;
  final String date;
  final int rating;
  final String text;

  const ReviewCard({
    super.key,
    required this.initials,
    required this.avatarColor,
    required this.initialColor,
    required this.name,
    required this.date,
    required this.rating,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC3C6D7)),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── User info row ─────────────────────────────────────
          Row(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: avatarColor,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 24 / 16,
                      color: initialColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Name + date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 16 / 16,
                      color: Color(0xFF191B23),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 20 / 14,
                      color: Color(0xFF737686),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // ── Star rating ───────────────────────────────────────
          Row(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Icon(
                  index < rating
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: 15,
                  color: const Color(0xFF943700),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          // ── Review text ───────────────────────────────────────
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF434655),
            ),
          ),
        ],
      ),
    );
  }
}

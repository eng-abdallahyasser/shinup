import 'package:flutter/material.dart';
import 'package:shinup/features/profile/presentation/cubit/profile_cubit.dart';

class LoyaltySection extends StatelessWidget {
  final int points;
  final String pointsLabel;
  final int pointsProgress;
  final List<LoyaltyActivity> recentActivities;
  final String loyaltyRewardsLabel;
  final String recentActivityLabel;
  final String redeemLabel;

  const LoyaltySection({
    super.key,
    required this.points,
    required this.pointsLabel,
    required this.pointsProgress,
    required this.recentActivities,
    required this.loyaltyRewardsLabel,
    required this.recentActivityLabel,
    required this.redeemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            loyaltyRewardsLabel.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
              color: Color(0xFF434655),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Points + Redeem button row
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Points column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pointsLabel,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Color(0xFF434655),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatPoints(points),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          letterSpacing: -0.28,
                          color: Color(0xFF004AC6),
                        ),
                      ),
                    ],
                  ),
                  // Redeem button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF006E2F),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      redeemLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: LinearProgressIndicator(
                    value: pointsProgress / 100,
                    backgroundColor: const Color(0xFFE1E2ED),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF004AC6),
                    ),
                  ),
                ),
              ),
              // Divider with Recent Activity
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: Divider(
                  color: Color(0xFFC3C6D7),
                  thickness: 1,
                ),
              ),
              Text(
                recentActivityLabel.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Color(0xFF434655),
                ),
              ),
              const SizedBox(height: 4),
              // Recent activity items
              ...recentActivities.map((a) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          a.label,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF191B23),
                          ),
                        ),
                        Text(
                          '${a.isPositive ? '+' : '-'}${a.points}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF006E2F),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  String _formatPoints(int pts) {
    // Format with commas: 2450 -> "2,450"
    final str = pts.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}

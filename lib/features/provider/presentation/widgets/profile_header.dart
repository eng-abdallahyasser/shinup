import 'package:flutter/material.dart';
import 'package:shineup/core/localization/app_localizations.dart';

class ProfileHeader extends StatelessWidget {
  final String nameBusiness;
  final bool availableIs;
  final String description;

  const ProfileHeader({
    super.key,
    required this.nameBusiness,
    required this.availableIs,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row: Name + Logo ──────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Name + rating + distance
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameBusiness,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 30 / 24,
                        color: Color(0xFF191B23),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        // TODO: Replace with dynamic rating from API
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 15,
                              color: const Color(0xFF943700),
                            ),
                            const SizedBox(width: 2),
                            const Text(
                              '4.8',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                height: 20 / 14,
                                color: Color(0xFF943700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        // TODO: Replace with dynamic distance from API
                        Text(
                          '${t.formatNumber(1.2)} ${t.providerUnitKmAway}',
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
              ),
              // TODO: Replace with dynamic logo image from API
              Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDF9),
                  border: Border.all(color: const Color(0xFFC3C6D7)),
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF004AC6).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.build_circle_outlined,
                      size: 28,
                      color: Color(0xFF004AC6),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Status row: Open badge + tagline ──────────────────
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: availableIs
                      ? const Color(0xFF6BFF8F)
                      : const Color(0xFFFFCDD2),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  availableIs ? t.homeStatusOpen : t.homeStatusClosed,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 16 / 12,
                    letterSpacing: 0.6,
                    color: availableIs
                        ? const Color(0xFF007432)
                        : const Color(0xFFC62828),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 20 / 14,
                    color: Color(0xFF434655),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

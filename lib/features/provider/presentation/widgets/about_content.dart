import 'package:flutter/material.dart';
import 'package:shineup/core/localization/app_localizations.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

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
            AppLocalizations.of(context).providerAboutTitle,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF191B23),
            ),
          ),
          SizedBox(height: 16),

          // ── Operating Hours ───────────────────────────────────
          _AboutRow(
            icon: Icons.access_time_rounded,
            title: AppLocalizations.of(context).providerAboutHours,
            children: [
              _HoursRow(
                day: AppLocalizations.of(context).providerAboutHoursWeekdays,
                time: AppLocalizations.of(context).providerAboutHoursWeekdaysTime,
              ),
              SizedBox(height: 4),
              _HoursRow(
                day: AppLocalizations.of(context).providerAboutHoursWeekend,
                time: AppLocalizations.of(context).providerAboutHoursWeekendTime,
              ),
            ],
          ),

          SizedBox(height: 16),

          // ── Phone ─────────────────────────────────────────────
          _AboutRow(
            icon: Icons.phone_rounded,
            title: AppLocalizations.of(context).providerAboutPhone,
            children: [
              Text(
                '+20 123 456 7890',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 20 / 14,
                  color: Color(0xFF434655),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // ── Specializations ───────────────────────────────────
          Text(
            AppLocalizations.of(context).providerAboutSpecializations,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          SizedBox(height: 8),
          _SpecializationsGrid(),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  About Row (icon + title + children)
// ═════════════════════════════════════════════════════════════════════════════

class _AboutRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _AboutRow({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 20, color: const Color(0xFF004AC6)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0xFF191B23),
                ),
              ),
              const SizedBox(height: 4),
              ...children,
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Hours Row (day + time)
// ═════════════════════════════════════════════════════════════════════════════

class _HoursRow extends StatelessWidget {
  final String day;
  final String time;

  const _HoursRow({required this.day, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
            color: Color(0xFF434655),
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
            color: Color(0xFF434655),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Specializations Grid
// ═════════════════════════════════════════════════════════════════════════════

class _SpecializationsGrid extends StatelessWidget {
  const _SpecializationsGrid();

  static const _specs = [
    'Express Wash',
    'Full Detailing',
    'Battery Service',
    'AC Repair',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _specs.map((spec) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDF9),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            spec,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 20 / 14,
              color: Color(0xFF434655),
            ),
          ),
        );
      }).toList(),
    );
  }
}

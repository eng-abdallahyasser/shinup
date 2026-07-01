import 'package:flutter/material.dart';
import 'package:shineup/core/localization/app_localizations.dart';

/// Step 3 of the booking flow — Review & Confirm.
class BookingStep3Page extends StatelessWidget {
  const BookingStep3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Scrollable content ──────────────────────────────
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 200),
              child: Column(
                children: [
                  const _TopAppBar(),
                  const _ProgressStepper(),
                  const _BookingDetailsCard(),
                  const _AdditionalOptions(),
                  const _PricingBreakdown(),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // ── Sticky Footer ───────────────────────────────────
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  TopAppBar — Back + "Review & Confirm" + User avatar
// ═════════════════════════════════════════════════════════════════════════════

class _TopAppBar extends StatelessWidget {
  const _TopAppBar();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FF),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 16,
                color: Color(0xFF004AC6),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Text(
            t.bookingReviewAndConfirm,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const Spacer(),
          // User avatar
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFEDEDF9),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person_outline_rounded,
                size: 20,
                color: Color(0xFF737686),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Progress Stepper — 3 steps with labels
// ═════════════════════════════════════════════════════════════════════════════

class _ProgressStepper extends StatelessWidget {
  const _ProgressStepper();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFFFAF8FF),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            // ── Circles + connecting lines ────────────────────────
            Row(
              children: [
                _StepCircle(
                  bgColor: Color(0xFF006E2F),
                  child: Icon(Icons.check_rounded, size: 14, color: Colors.white),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xFF006E2F)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                _StepCircle(
                  bgColor: Color(0xFF006E2F),
                  child: Icon(Icons.check_rounded, size: 14, color: Colors.white),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0x4D004AC6),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Step 3 glow circle
                _StepCircle(
                  bgColor: Color(0xFF2563EB),
                  glowColor: Color(0xFFDBE1FF),
                  child: Text(
                    '3',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 24 / 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // ── Labels ───────────────────────────────────────────
            Row(
              children: [
                _StepLabel(text: t.bookingSelectionLabel, color: const Color(0xFF006E2F)),
                const Spacer(),
                _StepLabel(text: t.bookingDateAndTimeLabel, color: const Color(0xFF006E2F)),
                const Spacer(),
                _StepLabel(text: t.bookingReviewLabel, color: const Color(0xFF004AC6)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  final Color bgColor;
  final Color? glowColor;
  final Widget child;

  const _StepCircle({
    required this.bgColor,
    this.glowColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: glowColor != null
            ? [
                BoxShadow(
                  color: glowColor!,
                  blurRadius: 0,
                  spreadRadius: 4,
                ),
              ]
            : null,
      ),
      child: Center(child: child),
    );
  }
}

class _StepLabel extends StatelessWidget {
  final String text;
  final Color color;

  const _StepLabel({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          height: 16 / 12,
          letterSpacing: 0.6,
          color: color,
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Booking Details Card
// ═════════════════════════════════════════════════════════════════════════════

class _BookingDetailsCard extends StatelessWidget {
  const _BookingDetailsCard();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        border: Border.all(
          color: const Color(0xFFC3C6D7).withValues(alpha: 0.3),
        ),
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
          // Heading
          Text(
            t.bookingDetails,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 16),

          // Provider row
          _DetailRow(
            circleColor: const Color(0xFFDBE1FF),
            icon: Icons.local_car_wash_outlined,
            iconColor: const Color(0xFF004AC6),
            iconSize: 18,
            label: t.bookingProvider,
            value: 'Shine & Co Detailing',
          ),
          const SizedBox(height: 16),

          // Date & Time row
          _DetailRow(
            circleColor: const Color(0xFF6BFF8F),
            icon: Icons.access_time_rounded,
            iconColor: const Color(0xFF006E2F),
            iconSize: 18,
            label: t.bookingDateAndTimeRow,
            value: 'Today, 2:00 PM',
            badge: Text(
              t.bookingAsapBadge,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 16 / 12,
                color: Color(0xFF434655),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Service row
          _DetailRow(
            circleColor: const Color(0xFFFFDBCD),
            icon: Icons.description_outlined,
            iconColor: const Color(0xFF943700),
            iconSize: 18,
            label: t.bookingServiceRow,
            value: 'Exterior Wash - \$35',
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final Color circleColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String label;
  final String value;
  final Widget? badge;

  const _DetailRow({
    required this.circleColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.label,
    required this.value,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon circle
        Container(
          width: 34,
          height: 34,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
        const SizedBox(width: 16),
        // Label + value
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  height: 16 / 12,
                  letterSpacing: 0.6,
                  color: Color(0xFF737686),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 24 / 16,
                      color: Color(0xFF191B23),
                    ),
                  ),
                  if (badge != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E7F3),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: badge,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Additional Options — Notes & Photos
// ═════════════════════════════════════════════════════════════════════════════

class _AdditionalOptions extends StatelessWidget {
  const _AdditionalOptions();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Notes ────────────────────────────────────────────
          Text(
            t.bookingNotes,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 8),
          const _NotesField(),
          const SizedBox(height: 24),

          // ── Photos ───────────────────────────────────────────
          Text(
            t.bookingPhotos,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 8),
          const _PhotoUploadArea(),
        ],
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        border: Border.all(color: const Color(0xFFC3C6D7)),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        t.bookingNotesPlaceholder,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          color: Color(0x80737686),
        ),
      ),
    );
  }
}

class _PhotoUploadArea extends StatelessWidget {
  const _PhotoUploadArea();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        border: Border.all(
          color: const Color(0xFFC3C6D7),
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 28,
            color: const Color(0xFF004AC6),
          ),
          const SizedBox(height: 8),
          Text(
            t.bookingPhotosHint,
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
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Pricing Breakdown
// ═════════════════════════════════════════════════════════════════════════════

class _PricingBreakdown extends StatelessWidget {
  const _PricingBreakdown();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3FE),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          // Exterior Wash
          const _PriceRow(
            label: 'Exterior Wash',
            amount: '\$35',
          ),
          const SizedBox(height: 12),

          // Service Fee
          _PriceRow(
            label: t.bookingServiceFee,
            amount: t.bookingFree,
            amountColor: Color(0xFF006E2F),
          ),
          const SizedBox(height: 12),

          // Divider
          const Divider(
            height: 1,
            color: Color(0x4DC3C6D7),
            thickness: 1,
          ),
          const SizedBox(height: 12),

          // Total
          _PriceRow(
            label: t.bookingTotal,
            amount: '\$35',
            labelStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF191B23),
            ),
            amountStyle: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF004AC6),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String amount;
  final Color? amountColor;
  final TextStyle? labelStyle;
  final TextStyle? amountStyle;

  const _PriceRow({
    required this.label,
    required this.amount,
    this.amountColor,
    this.labelStyle,
    this.amountStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ??
              const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                color: Color(0xFF434655),
              ),
        ),
        Text(
          amount,
          style: amountStyle ??
              TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                color: amountColor ?? const Color(0xFF191B23),
              ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Footer — Confirm Booking
// ═════════════════════════════════════════════════════════════════════════════

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFFAF8FF),
          border: Border(
            top: BorderSide(color: Color(0xFFC3C6D7)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Confirm Booking button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  shadowColor: const Color(0xFF004AC6).withValues(alpha: 0.2),
                ),
                child: Text(
                  t.bookingConfirm,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 24 / 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Disclaimer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                t.bookingDisclaimer,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 18 / 14,
                  color: Color(0xFF737686),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

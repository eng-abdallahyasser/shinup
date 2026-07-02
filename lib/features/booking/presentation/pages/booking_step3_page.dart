import 'package:flutter/material.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/booking/data/models/booking_flow_data.dart';
import 'package:shineup/features/booking/domain/repositories/booking_repository.dart';

class BookingStep3Page extends StatefulWidget {
  final BookingFlowData? flowData;

  const BookingStep3Page({super.key, this.flowData});

  @override
  State<BookingStep3Page> createState() => _BookingStep3PageState();
}

class _BookingStep3PageState extends State<BookingStep3Page> {
  final BookingRepository _bookingRepo = sl<BookingRepository>();
  late BookingFlowData _flowData;
  bool _isSubmitting = false;

  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _instructionsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _flowData = widget.flowData ??
        BookingFlowData(
          providerId: '',
          providerName: '',
          selectedServices: [],
        );
  }

  @override
  void dispose() {
    _notesController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _confirmBooking() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    try {
      final updatedFlow = _flowData.copyWith(
        notes: _notesController.text,
        instructions: _instructionsController.text,
      );
      final request = updatedFlow.toCreateRequest();
      await _bookingRepo.createBooking(request);

      if (mounted) {
        final t = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.bookingConfirmed)),
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.main,
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        final t = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${t.bookingFailedCreate}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 200),
              child: Column(
                children: [
                  const _TopAppBar(),
                  const _ProgressStepper(),
                  _BookingDetailsCard(flowData: _flowData),
                  _AdditionalOptions(
                    notesController: _notesController,
                    instructionsController: _instructionsController,
                  ),
                  _PricingBreakdown(
                    services: _flowData.selectedServices,
                    totalCost: _flowData.totalCost,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            _Footer(
              isSubmitting: _isSubmitting,
              totalCost: _flowData.totalCost,
              onConfirm: _confirmBooking,
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  TopAppBar
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
          Text(
            t.bookingReviewAndConfirm,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const Spacer(),
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
//  Progress Stepper
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
            Row(
              children: [
                _StepCircle(
                  bgColor: const Color(0xFF006E2F),
                  child: const Icon(Icons.check_rounded,
                      size: 14, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 2,
                    child: DecoratedBox(
                      decoration:
                          const BoxDecoration(color: Color(0xFF006E2F)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _StepCircle(
                  bgColor: const Color(0xFF006E2F),
                  child: const Icon(Icons.check_rounded,
                      size: 14, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 2,
                    child: DecoratedBox(
                      decoration:
                          const BoxDecoration(color: Color(0x4D004AC6)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _StepCircle(
                  bgColor: const Color(0xFF2563EB),
                  glowColor: const Color(0xFFDBE1FF),
                  child: const Text(
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
            const SizedBox(height: 8),
            Row(
              children: [
                _StepLabel(
                    text: t.bookingSelectionLabel,
                    color: const Color(0xFF006E2F)),
                const Spacer(),
                _StepLabel(
                    text: t.bookingDateAndTimeLabel,
                    color: const Color(0xFF006E2F)),
                const Spacer(),
                _StepLabel(
                    text: t.bookingReviewLabel,
                    color: const Color(0xFF004AC6)),
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
  final BookingFlowData flowData;

  const _BookingDetailsCard({required this.flowData});

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
          Text(
            t.bookingDetails,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 16),
          _DetailRow(
            circleColor: const Color(0xFFDBE1FF),
            icon: Icons.local_car_wash_outlined,
            iconColor: const Color(0xFF004AC6),
            iconSize: 18,
            label: t.bookingProvider,
            value: flowData.providerName,
          ),
          const SizedBox(height: 16),
          _DetailRow(
            circleColor: const Color(0xFF6BFF8F),
            icon: Icons.access_time_rounded,
            iconColor: const Color(0xFF006E2F),
            iconSize: 18,
            label: t.bookingDateAndTimeRow,
            value: flowData.bookingTimeMode == 'NOW'
                ? t.bookingAsap
                : t.bookingScheduled,
            badge: flowData.bookingTimeMode == 'NOW'
                ? Text(
                    t.bookingAsapBadge,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 16 / 12,
                      color: Color(0xFF434655),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          _DetailRow(
            circleColor: const Color(0xFFFFDBCD),
            icon: Icons.shopping_cart_outlined,
            iconColor: const Color(0xFF943700),
            iconSize: 18,
            label: t.bookingServiceRow,
            value: flowData.selectedServices.map((s) => s.name).join(', '),
          ),
          if (flowData.carDisplay != null) ...[
            const SizedBox(height: 16),
            _DetailRow(
              circleColor: const Color(0xFFDBE1FF),
              icon: Icons.directions_car_rounded,
              iconColor: const Color(0xFF004AC6),
              iconSize: 18,
              label: t.bookingCar,
              value: flowData.carDisplay!,
            ),
          ],
          if (flowData.addressDisplay != null) ...[
            const SizedBox(height: 16),
            _DetailRow(
              circleColor: const Color(0xFFFFDBCD),
              icon: Icons.location_on_outlined,
              iconColor: const Color(0xFF943700),
              iconSize: 18,
              label: t.bookingAddress,
              value: flowData.addressDisplay!,
            ),
          ],
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
                  Expanded(
                    child: Text(
                      value,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF191B23),
                      ),
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
//  Additional Options
// ═════════════════════════════════════════════════════════════════════════════

class _AdditionalOptions extends StatelessWidget {
  final TextEditingController notesController;
  final TextEditingController instructionsController;

  const _AdditionalOptions({
    required this.notesController,
    required this.instructionsController,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.bookingNotes,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF8FF),
              border: Border.all(color: const Color(0xFFC3C6D7)),
              borderRadius: BorderRadius.circular(32),
            ),
            child: TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: t.bookingNotesPlaceholder,
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0x80737686),
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                color: Color(0xFF191B23),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.bookingInstructions,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF8FF),
              border: Border.all(color: const Color(0xFFC3C6D7)),
              borderRadius: BorderRadius.circular(32),
            ),
            child: TextField(
              controller: instructionsController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: t.bookingInstructionsPlaceholder,
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0x80737686),
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                color: Color(0xFF191B23),
              ),
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
  final List<SelectedService> services;
  final double totalCost;

  const _PricingBreakdown({
    required this.services,
    required this.totalCost,
  });

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
          ...services.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PriceRow(
                  label: s.name,
                  amount: '\$${s.price.toStringAsFixed(0)}',
                ),
              )),
          _PriceRow(
            label: t.bookingServiceFee,
            amount: t.bookingFree,
            amountColor: const Color(0xFF006E2F),
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 1,
            color: Color(0x4DC3C6D7),
            thickness: 1,
          ),
          const SizedBox(height: 12),
          _PriceRow(
            label: t.bookingTotal,
            amount: '\$${totalCost.toStringAsFixed(0)}',
            labelStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 28 / 20,
              color: Color(0xFF191B23),
            ),
            amountStyle: const TextStyle(
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
//  Footer
// ═════════════════════════════════════════════════════════════════════════════

class _Footer extends StatelessWidget {
  final bool isSubmitting;
  final double totalCost;
  final VoidCallback onConfirm;

  const _Footer({
    required this.isSubmitting,
    required this.totalCost,
    required this.onConfirm,
  });

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
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  disabledBackgroundColor: const Color(0xFFC3C6D7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  shadowColor:
                      const Color(0xFF004AC6).withValues(alpha: 0.2),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        t.bookingConfirm,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 24 / 16,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                t.bookingDisclaimer,
                textAlign: TextAlign.center,
                style: const TextStyle(
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

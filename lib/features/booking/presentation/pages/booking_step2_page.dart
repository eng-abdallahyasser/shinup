import 'package:flutter/material.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/core/routes/app_pages.dart';

/// Step 2 of the booking flow — Date & Time selection.
///
/// Allows the user to choose between:
/// - **ASAP** (nearest available time)
/// - **Schedule** (pick a specific date + time slot)
class BookingStep2Page extends StatefulWidget {
  const BookingStep2Page({super.key});

  @override
  State<BookingStep2Page> createState() => _BookingStep2PageState();
}

class _BookingStep2PageState extends State<BookingStep2Page> {
  /// true = ASAP, false = Schedule
  bool _isAsap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Scrollable content ──────────────────────────────
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  const _TopAppBar(),
                  const _ProgressStepper(),
                  const _ProviderContext(),
                  _AsapToggle(
                    isAsap: _isAsap,
                    onToggle: (val) => setState(() => _isAsap = val),
                  ),
                  if (!_isAsap) const _ScheduleSection(),
                ],
              ),
            ),

            // ── Sticky Footer ───────────────────────────────────
            const _BottomCta(),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  TopAppBar — Back + "Book Service" + User avatar
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
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(4),
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
            t.bookingTitle,
            style: const TextStyle(
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
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC3C6D7)),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: const Center(
              child: Icon(
                Icons.person_outline_rounded,
                size: 18,
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
//  Progress Stepper — 3 steps
// ═════════════════════════════════════════════════════════════════════════════

class _ProgressStepper extends StatelessWidget {
  const _ProgressStepper();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFFFAF8FF),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Connecting line
          const Positioned(
            left: 60,
            right: 60,
            top: 40,
            child: SizedBox(
              height: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFE1E2ED)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StepDot(
                number: '✓',
                isActive: true,
                isCompleted: true,
                label: t.bookingSelection,
              ),
              _StepDot(
                number: '2',
                isActive: true,
                isCompleted: true,
                label: t.bookingDateAndTime,
              ),
              _StepDot(
                number: '3',
                isActive: false,
                isCompleted: false,
                label: t.bookingReview,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final String number;
  final bool isActive;
  final bool isCompleted;
  final String label;

  const _StepDot({
    required this.number,
    required this.isActive,
    required this.isCompleted,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final circleColor =
        isCompleted ? const Color(0xFF2563EB) : const Color(0xFFFAF8FF);
    final borderColor =
        isCompleted ? null : const Color(0xFFC3C6D7);
    final textColor =
        isCompleted ? const Color(0xFFEEEFFF) : const Color(0xFF737686);
    final labelColor =
        isActive ? const Color(0xFF004AC6) : const Color(0xFF737686);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: circleColor,
              border: borderColor != null
                  ? Border.all(color: borderColor, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 20 / 14,
                  color: textColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              fontSize: 10,
              height: 15 / 10,
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Provider Context — booking info banner
// ═════════════════════════════════════════════════════════════════════════════

class _ProviderContext extends StatelessWidget {
  const _ProviderContext();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking · ${t.bookingWash}',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF004AC6),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Book Shine & Co. Detailing',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Color(0xFF737686),
              ),
              const SizedBox(width: 8),
              const Text(
                '123 Auto Care Street, Downtown',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0xFF434655),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  ASAP Toggle — Card before the date selector
// ═════════════════════════════════════════════════════════════════════════════

class _AsapToggle extends StatelessWidget {
  final bool isAsap;
  final ValueChanged<bool> onToggle;

  const _AsapToggle({
    required this.isAsap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Two options: ASAP | Schedule ──────────────────────
          Row(
            children: [
              Expanded(
                child: _BookingOptionCard(
                  icon: Icons.flash_on_rounded,
                  title: t.bookingAsap,
                  subtitle: t.bookingNearestAvailable,
                  isSelected: isAsap,
                  onTap: () => onToggle(true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BookingOptionCard(
                  icon: Icons.calendar_today_rounded,
                  title: t.bookingSchedule,
                  subtitle: t.bookingPickDateAndTime,
                  isSelected: !isAsap,
                  onTap: () => onToggle(false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Nearest Available card (shown when ASAP selected) ─
          if (isAsap)
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: const Color(0xFFC3C6D7)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  children: [
                    // Background gradient
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A237E), Color(0xFF004AC6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    // Dark overlay
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0x99404040),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.bookingNearestAvailable,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              height: 15 / 10,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            t.bookingInMinutes,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 24 / 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _BookingOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _BookingOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0x1A2563EB)
              : const Color(0xFFFAF8FF),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFFC3C6D7),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFF434655),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 20 / 14,
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF191B23),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 16 / 12,
                      color: Color(0xFF737686),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Schedule Section — Date pills + Time slot grid
// ═════════════════════════════════════════════════════════════════════════════

class _ScheduleSection extends StatefulWidget {
  const _ScheduleSection();

  @override
  State<_ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<_ScheduleSection> {
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 1;

  static const _weekDays = [
    _DayData('MON', '24'),
    _DayData('TUE', '25'),
    _DayData('WED', '26'),
    _DayData('THU', '27'),
    _DayData('FRI', '28'),
    _DayData('SAT', '29'),
  ];

  // 3 rows × 3 columns
  static const _timeSlots = [
    ['9:00', '10:30', '12:00'],
    ['1:30', '3:00', '4:30'],
    ['6:00', '7:30', '9:00'],
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Date pills ─────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.bookingSelectDate,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0xFF191B23),
                ),
              ),
              Text(
                '${_weekDays.length} ${t.bookingAvailable}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0xFF737686),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 88,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _weekDays.length,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final day = _weekDays[index];
                final isSelected = index == _selectedDateIndex;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedDateIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 64,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : const Color(0xFFFAF8FF),
                      border: isSelected
                          ? null
                          : Border.all(color: const Color(0xFFC3C6D7)),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: isSelected
                          ? const [
                              BoxShadow(
                                color: Color(0x1A000000),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.day,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 24 / 16,
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.8)
                                : const Color(0xFF434655),
                          ),
                        ),
                        Text(
                          day.date,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 24 / 16,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF191B23),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // ── Time slot grid ─────────────────────────────────────
          Text(
            t.bookingSelectTimeSlot,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_timeSlots.length, (rowIndex) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: rowIndex < _timeSlots.length - 1 ? 12 : 0),
              child: Row(
                children: List.generate(
                    _timeSlots[rowIndex].length, (colIndex) {
                  final globalIndex =
                      rowIndex * _timeSlots[rowIndex].length + colIndex;
                  final time = _timeSlots[rowIndex][colIndex];
                  final isSelected = globalIndex == _selectedTimeIndex;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: colIndex == 0 ? 0 : 6,
                        right: colIndex ==
                                _timeSlots[rowIndex].length - 1
                            ? 0
                            : 6,
                      ),
                      child: GestureDetector(
                        onTap: () => setState(
                            () => _selectedTimeIndex = globalIndex),
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 200),
                          height: 58,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2563EB)
                                : const Color(0xFFFAF8FF),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: const Color(0xFFC3C6D7)),
                            borderRadius:
                                BorderRadius.circular(9999),
                            boxShadow: isSelected
                                ? const [
                                    BoxShadow(
                                      color: Color(0x1A000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              time,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 24 / 16,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF191B23),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DayData {
  final String day;
  final String date;
  const _DayData(this.day, this.date);
}

// ═════════════════════════════════════════════════════════════════════════════
//  Bottom CTA — Order summary
// ═════════════════════════════════════════════════════════════════════════════

class _BottomCta extends StatelessWidget {
  const _BottomCta();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: const BoxDecoration(
          color: Color(0xFFFAF8FF),
          border: Border(
            top: BorderSide(color: Color(0xFFC3C6D7)),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Summary text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.bookingNearestAvailable,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 24 / 16,
                    color: Color(0xFF434655),
                  ),
                ),
                const Text(
                  '\$35',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 24 / 16,
                    color: Color(0xFF004AC6),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 66),
            // Continue button
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.bookingStep3);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    t.bookingContinue,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 24 / 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

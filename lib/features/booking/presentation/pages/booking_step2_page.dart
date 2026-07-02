import 'package:flutter/material.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/booking/data/models/booking_flow_data.dart';
import 'package:shineup/features/profile/data/models/address_models.dart';
import 'package:shineup/features/profile/data/models/car_models.dart';
import 'package:shineup/features/profile/domain/repositories/profile_repository.dart';

/// Step 2 of the booking flow — Date & Time + Car + Address.
class BookingStep2Page extends StatefulWidget {
  final BookingFlowData? flowData;

  const BookingStep2Page({super.key, this.flowData});

  @override
  State<BookingStep2Page> createState() => _BookingStep2PageState();
}

class _BookingStep2PageState extends State<BookingStep2Page> {
  final ProfileRepository _profileRepo = sl<ProfileRepository>();

  late BookingFlowData _flowData;

  bool _isLoading = true;
  bool _isAsap = true;
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 1;

  List<UserCarModel> _cars = [];
  List<AddressModel> _addresses = [];
  String? _selectedCarId;
  String? _selectedAddressId;

  @override
  void initState() {
    super.initState();
    _flowData = widget.flowData ??
        BookingFlowData(
          providerId: '',
          providerName: '',
          selectedServices: [],
        );
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final cars = await _profileRepo.getCars();
      final addresses = await _profileRepo.getAddresses();
      if (mounted) {
        setState(() {
          _cars = cars;
          _addresses = addresses;
          _selectedCarId = cars.where((c) => c.defaultIs).firstOrNull?.id;
          _selectedAddressId =
              addresses.where((a) => a.defaultIs).firstOrNull?.id;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onContinue() {
    if (_selectedCarId == null || _selectedAddressId == null) return;

    final car = _cars.where((c) => c.id == _selectedCarId).firstOrNull;
    final addr =
        _addresses.where((a) => a.id == _selectedAddressId).firstOrNull;

    final updatedFlow = _flowData.copyWith(
      bookingTimeMode: _isAsap ? 'NOW' : 'SCHEDULED',
      carId: _selectedCarId,
      carDisplay: car?.displayName,
      addressId: _selectedAddressId,
      addressDisplay: addr?.displayAddress,
    );

    Navigator.of(context).pushNamed(
      AppRouter.bookingStep3,
      arguments: updatedFlow,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAF8FF),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  _TopAppBar(
                    providerName: _flowData.providerName,
                  ),
                  const _ProgressStepper(),
                  _ServiceSummary(
                    services: _flowData.selectedServices,
                    totalCost: _flowData.totalCost,
                  ),
                  _CarSelector(
                    cars: _cars,
                    selectedCarId: _selectedCarId,
                    onChanged: (id) => setState(() => _selectedCarId = id),
                  ),
                  _AddressSelector(
                    addresses: _addresses,
                    selectedAddressId: _selectedAddressId,
                    onChanged: (id) =>
                        setState(() => _selectedAddressId = id),
                  ),
                  _AsapToggle(
                    isAsap: _isAsap,
                    onToggle: (val) => setState(() => _isAsap = val),
                  ),
                  if (!_isAsap) _ScheduleSection(
                    selectedDateIndex: _selectedDateIndex,
                    selectedTimeIndex: _selectedTimeIndex,
                    onDateChanged: (i) =>
                        setState(() => _selectedDateIndex = i),
                    onTimeChanged: (i) =>
                        setState(() => _selectedTimeIndex = i),
                  ),
                ],
              ),
            ),
            _PositionedBottomCta(
              enabled:
                  _selectedCarId != null && _selectedAddressId != null,
              onContinue: _onContinue,
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
  final String providerName;

  const _TopAppBar({required this.providerName});

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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
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
    final borderColor = isCompleted ? null : const Color(0xFFC3C6D7);
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
//  Service Summary
// ═════════════════════════════════════════════════════════════════════════════

class _ServiceSummary extends StatelessWidget {
  final List<SelectedService> services;
  final double totalCost;

  const _ServiceSummary({
    required this.services,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${t.bookingWash} · ${services.length} ${t.providerCtaServices}',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF004AC6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _flowProviderName(context),
            style: const TextStyle(
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
                Icons.shopping_cart_outlined,
                size: 14,
                color: Color(0xFF737686),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  services.map((s) => s.name).join(', '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 20 / 14,
                    color: Color(0xFF434655),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _flowProviderName(BuildContext context) {
    // We use a simple approach since we can't access flowData directly here
    return 'Booking';
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Car Selector
// ═════════════════════════════════════════════════════════════════════════════

class _CarSelector extends StatelessWidget {
  final List<UserCarModel> cars;
  final String? selectedCarId;
  final ValueChanged<String> onChanged;

  const _CarSelector({
    required this.cars,
    required this.selectedCarId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.bookingSelectCar,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 8),
          ...cars.map((car) {
            final isSelected = car.id == selectedCarId;
            return GestureDetector(
              onTap: () => onChanged(car.id),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
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
                      Icons.directions_car_rounded,
                      size: 20,
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF434655),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.displayName,
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
                            '${car.year} · ${car.plateNumber}',
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
                    if (isSelected)
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 20,
                        color: Color(0xFF2563EB),
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Address Selector
// ═════════════════════════════════════════════════════════════════════════════

class _AddressSelector extends StatelessWidget {
  final List<AddressModel> addresses;
  final String? selectedAddressId;
  final ValueChanged<String> onChanged;

  const _AddressSelector({
    required this.addresses,
    required this.selectedAddressId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.bookingSelectAddress,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 8),
          ...addresses.map((addr) {
            final isSelected = addr.id == selectedAddressId;
            return GestureDetector(
              onTap: () => onChanged(addr.id),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
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
                      Icons.location_on_outlined,
                      size: 20,
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF434655),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addr.title,
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
                            addr.displayAddress,
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
                    if (isSelected)
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 20,
                        color: Color(0xFF2563EB),
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  ASAP Toggle
// ═════════════════════════════════════════════════════════════════════════════

class _AsapToggle extends StatelessWidget {
  final bool isAsap;
  final ValueChanged<bool> onToggle;

  const _AsapToggle({required this.isAsap, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A237E), Color(0xFF004AC6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
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
//  Schedule Section
// ═════════════════════════════════════════════════════════════════════════════

class _ScheduleSection extends StatelessWidget {
  final int selectedDateIndex;
  final int selectedTimeIndex;
  final ValueChanged<int> onDateChanged;
  final ValueChanged<int> onTimeChanged;

  const _ScheduleSection({
    required this.selectedDateIndex,
    required this.selectedTimeIndex,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  static const _weekDays = [
    _DayData('MON', '24'),
    _DayData('TUE', '25'),
    _DayData('WED', '26'),
    _DayData('THU', '27'),
    _DayData('FRI', '28'),
    _DayData('SAT', '29'),
  ];

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
          const SizedBox(height: 16),
          SizedBox(
            height: 88,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _weekDays.length,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final day = _weekDays[index];
                final isSelected = index == selectedDateIndex;
                return GestureDetector(
                  onTap: () => onDateChanged(index),
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
                  final isSelected = globalIndex == selectedTimeIndex;
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
                        onTap: () => onTimeChanged(globalIndex),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
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
//  Bottom CTA
// ═════════════════════════════════════════════════════════════════════════════

class _PositionedBottomCta extends StatelessWidget {
  final bool enabled;
  final VoidCallback onContinue;

  const _PositionedBottomCta({
    required this.enabled,
    required this.onContinue,
  });

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
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: enabled ? onContinue : null,
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    t.bookingContinue,
                    style: const TextStyle(
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
                    disabledBackgroundColor: const Color(0xFFC3C6D7),
                    disabledForegroundColor: const Color(0xFF737686),
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

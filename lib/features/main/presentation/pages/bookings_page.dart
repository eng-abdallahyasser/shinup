import 'package:flutter/material.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const _TopAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 96),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_FilterBar(), _BookingsList()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  TopAppBar — Menu + "Shinup" + Notification bell
// ═════════════════════════════════════════════════════════════════════════════

class _TopAppBar extends StatelessWidget {
  const _TopAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FF),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // ❖ Menu icon + Brand
          Row(
            children: [
              Icon(Icons.menu, size: 20, color: const Color(0xFF004AC6)),
              const SizedBox(width: 8),
              const Text(
                'My Bookings',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 30 / 24,
                  color: Color(0xFF004AC6),
                ),
              ),
            ],
          ),
          const Spacer(),
          // ❖ Notification bell
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.notifications_outlined,
              size: 20,
              color: const Color(0xFF434655),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Filter Bar — Upcoming / Past / Cancelled
// ═════════════════════════════════════════════════════════════════════════════

class _FilterBar extends StatefulWidget {
  const _FilterBar();

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  int _selectedIndex = 0;

  static const _filters = ['Upcoming', 'Past', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: SizedBox(
        height: 52,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final isActive = _selectedIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: UnconstrainedBox(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFE7E7F3),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    _filters[index],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: isActive
                          ? const Color(0xFFEEEFFF)
                          : const Color(0xFF434655),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Bookings List
// ═════════════════════════════════════════════════════════════════════════════

class _BookingsList extends StatelessWidget {
  const _BookingsList();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          // Card 1: Confirmed
          _BookingCard(
            icon: Icons.local_car_wash_rounded,
            iconBgColor: Color(0xFFDBE1FF),
            iconColor: Color(0xFF004AC6),
            providerName: 'Shine & Co',
            service: 'Full Exterior Polish\n& Wax',
            status: 'Confirmed',
            statusBgColor: Color(0x1A2563EB),
            statusTextColor: Color(0xFF2563EB),
            date: 'Wed, Jun 24',
            time: '10:30 AM',
            primaryAction: 'Reschedule',
            secondaryAction: 'Cancel',
            height: 236,
          ),

          SizedBox(height: 16),

          // Card 2: Ready
          _BookingCard(
            icon: Icons.check_circle_rounded,
            iconBgColor: Color(0xFF6BFF8F),
            iconColor: Color(0xFF007432),
            providerName: 'Garage 37',
            service: 'Full Exterior Polish\n& Wax',
            status: 'Ready',
            statusBgColor: Color(0x1ABC4800),
            statusTextColor: Color(0xFF943700),
            date: 'Thu, Jun 26',
            time: '2:00 PM',
            primaryAction: 'Directions',
            secondaryAction: 'Call',
            height: 220,
          ),

          SizedBox(height: 16),

          // Promo Card
          _PromoCard(),

          SizedBox(height: 16),

          // Card 3: Pending
          _BookingCard(
            icon: Icons.access_time_rounded,
            iconBgColor: Color(0xFFE7E7F3),
            iconColor: Color(0xFF737686),
            providerName: 'Elite Detail Co.',
            service: 'Full Exterior Polish\n& Wax',
            status: 'Pending',
            statusBgColor: Color(0xFFE1E2ED),
            statusTextColor: Color(0xFF434655),
            date: 'Mon, Jun 30',
            time: '9:00 AM',
            primaryAction: 'Track',
            secondaryAction: 'Cancel',
            height: 220,
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Booking Card
// ═════════════════════════════════════════════════════════════════════════════

class _BookingCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String providerName;
  final String service;
  final String status;
  final Color statusBgColor;
  final Color statusTextColor;
  final String date;
  final String time;
  final String primaryAction;
  final String secondaryAction;
  final double height;

  const _BookingCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.providerName,
    required this.service,
    required this.status,
    required this.statusBgColor,
    required this.statusTextColor,
    required this.date,
    required this.time,
    required this.primaryAction,
    required this.secondaryAction,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
          // ── Row 1: Icon + Info + Status badge ──────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Provider icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 16),
              // Name + service
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      providerName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF191B23),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      service,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xFF434655),
                      ),
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 16 / 12,
                    letterSpacing: 0.6,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Row 2: Date & Time ────────────────────────────────
          Column(
            children: [
              // Date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: const Color(0xFF434655),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 20 / 14,
                      color: Color(0xFF434655),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Time
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: const Color(0xFF737686),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
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
          const SizedBox(height: 16),

          // ── Row 3: Action buttons ──────────────────────────────
          Row(
            children: [
              // Primary action (filled)
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: const Color(0xFFEEEFFF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: Text(
                      primaryAction,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Secondary action (outlined)
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF191B23),
                      side: const BorderSide(color: Color(0xFFC3C6D7)),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      secondaryAction,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Promo Card — "Upgrade to Shinup Pro"
// ═════════════════════════════════════════════════════════════════════════════

class _PromoCard extends StatelessWidget {
  const _PromoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Background image placeholder (dark teal)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF004AC6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Dark gradient overlay (matching design spec)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0x33000000),
                      Color(0xCC000000),
                    ],
                  ),
                ),
              ),
            ),
            // Decorative sparkle icon
            Positioned(
              right: -10,
              top: -20,
              child: Opacity(
                opacity: 0.15,
                child: const Icon(
                  Icons.star_rounded,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            // Content at bottom
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upgrade to Shinup Pro',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 28 / 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Get priority bookings and 15% off on all luxury details.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 20 / 14,
                      color: Colors.white.withValues(alpha: 0.8),
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

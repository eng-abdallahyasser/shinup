import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/features/booking/data/models/booking_model.dart';
import 'package:shineup/features/booking/presentation/cubit/booking_cubit.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().loadBookings();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<BookingCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      cubit.loadMoreBookings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              const _TopAppBar(),
              const _FilterBar(),
              Expanded(
                child: _buildBody(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(BookingState state) {
    switch (state.status) {
      case BookingStatus.initial:
      case BookingStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case BookingStatus.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.errorMessage ?? AppLocalizations.of(context).bookingSomethingWrong,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Color(0xFF737686),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      context.read<BookingCubit>().loadBookings(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context).bookingRetry),
                ),
              ],
            ),
          ),
        );
      case BookingStatus.loaded:
      case BookingStatus.loadingMore:
        if (state.filteredBookings.isEmpty) {
          return _buildEmptyState();
        }
        return _buildList(state);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 64,
            color: const Color(0xFFC3C6D7),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).bookingNoBookings,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF434655),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).bookingEmptySubtitle,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Color(0xFF737686),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BookingState state) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<BookingCubit>().loadBookings();
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 96),
        itemCount: state.filteredBookings.length +
            (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.filteredBookings.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final booking = state.filteredBookings[index];
          return _BookingCard(
            booking: booking,
            isCancelling: state.cancellingBookingId == booking.id,
            onCancel: () => _showCancelDialog(context, booking),
          );
        },
      ),
    );
  }

  void _showCancelDialog(BuildContext context, BookingModel booking) {
    showDialog(
      context: context,
      builder: (ctx) {
        final t = AppLocalizations.of(ctx);
        return AlertDialog(
          title: Text(t.bookingCancelTitle),
          content: Text(t.bookingCancelConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(t.bookingCancelKeep),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                context.read<BookingCubit>().cancelBooking(booking.id);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text(t.bookingCancelAction),
            ),
          ],
        );
      },
    );
  }
}

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
          Row(
            children: [
              Icon(Icons.menu, size: 20, color: const Color(0xFF004AC6)),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).bookingMyBookings,
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

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  static const _filters = [
    BookingFilter.upcoming,
    BookingFilter.past,
    BookingFilter.cancelled,
  ];

  static List<String> labels(BuildContext context) {
    final t = AppLocalizations.of(context);
    return [t.bookingFilterUpcoming, t.bookingFilterPast, t.bookingFilterCancelled];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: SizedBox(
        height: 52,
        child: BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isActive = state.filter == _filters[index];
                return GestureDetector(
                  onTap: () {
                    context.read<BookingCubit>().changeFilter(_filters[index]);
                  },
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
                        labels(context)[index],
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
            );
          },
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingModel booking;
  final bool isCancelling;
  final VoidCallback onCancel;

  const _BookingCard({
    required this.booking,
    required this.isCancelling,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final status = booking.customerStatus;
    final statusConfig = _statusConfig(status.code);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: statusConfig.bgColor,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Icon(
                    statusConfig.icon,
                    size: 20,
                    color: statusConfig.iconColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.providerName,
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
                        booking.servicesLabel,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusConfig.badgeBgColor,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    status.label.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      height: 16 / 12,
                      letterSpacing: 0.6,
                      color: statusConfig.badgeTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (booking.scheduledAt != null) ...[
              _InfoRow(
                icon: Icons.calendar_today_rounded,
                text: _formatDate(booking.scheduledAt!, t),
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.access_time_rounded,
                text: _formatTime(booking.scheduledAt!, t),
              ),
              const SizedBox(height: 8),
            ],
            if (booking.location != null) ...[
              _InfoRow(
                icon: Icons.location_on_outlined,
                text: '${booking.location!.area}, ${booking.location!.city}',
              ),
              const SizedBox(height: 8),
            ],
            if (booking.items.isNotEmpty) ...[
              _InfoRow(
                icon: Icons.attach_money_rounded,
                text:
                    '${booking.totalPriceCustomer} ${booking.items.first.currency}',
              ),
              const SizedBox(height: 8),
            ],
            if (booking.car != null)
              _InfoRow(
                icon: Icons.directions_car_rounded,
                text:
                    '${booking.car!.brand} ${booking.car!.model} - ${booking.car!.plateNumber}',
              ),
            if (_canCancel(status.code)) ...[
              const SizedBox(height: 16),
              BlocListener<BookingCubit, BookingState>(
                listener: (context, state) {
                  if (state.cancelErrorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.cancelErrorMessage!),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    context.read<BookingCubit>().dismissCancelMessage();
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: isCancelling ? null : onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFDC2626),
                      side: const BorderSide(color: Color(0xFFDC2626)),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: isCancelling
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFDC2626),
                            ),
                          )
                        : Text(
                            t.bookingCancelBtn,
                            style: TextStyle(
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
          ],
        ),
      ),
    );
  }

  bool _canCancel(String statusCode) {
    return statusCode == 'PENDING' || statusCode == 'CONFIRMED';
  }

  String _formatDate(DateTime date, AppLocalizations t) {
    return '${t.days[date.weekday - 1]}, ${t.months[date.month - 1]} ${date.day}';
  }

  String _formatTime(DateTime date, AppLocalizations t) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final ampm = date.hour >= 12 ? t.timePM : t.timeAM;
    return '$hour:$minute $ampm';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF737686)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 20 / 14,
              color: Color(0xFF434655),
            ),
          ),
        ),
      ],
    );
  }
}

_StatusConfig _statusConfig(String code) {
  switch (code) {
    case 'PENDING':
      return _StatusConfig(
        icon: Icons.access_time_rounded,
        bgColor: const Color(0xFFE7E7F3),
        iconColor: const Color(0xFF737686),
        badgeBgColor: const Color(0xFFE1E2ED),
        badgeTextColor: const Color(0xFF434655),
      );
    case 'CONFIRMED':
      return _StatusConfig(
        icon: Icons.check_circle_rounded,
        bgColor: const Color(0xFFDBE1FF),
        iconColor: const Color(0xFF004AC6),
        badgeBgColor: const Color(0x1A2563EB),
        badgeTextColor: const Color(0xFF2563EB),
      );
    case 'IN_PROGRESS':
      return _StatusConfig(
        icon: Icons.local_car_wash_rounded,
        bgColor: const Color(0xFFFFF3E0),
        iconColor: const Color(0xFFE65100),
        badgeBgColor: const Color(0x1AE65100),
        badgeTextColor: const Color(0xFFE65100),
      );
    case 'COMPLETED':
      return _StatusConfig(
        icon: Icons.check_circle_rounded,
        bgColor: const Color(0xFF6BFF8F).withValues(alpha: 0.3),
        iconColor: const Color(0xFF007432),
        badgeBgColor: const Color(0x1ABC4800),
        badgeTextColor: const Color(0xFF943700),
      );
    case 'CANCELLED':
      return _StatusConfig(
        icon: Icons.cancel_rounded,
        bgColor: const Color(0xFFFEE2E2),
        iconColor: const Color(0xFFDC2626),
        badgeBgColor: const Color(0x1ADC2626),
        badgeTextColor: const Color(0xFFDC2626),
      );
    default:
      return _StatusConfig(
        icon: Icons.info_outline,
        bgColor: const Color(0xFFE7E7F3),
        iconColor: const Color(0xFF737686),
        badgeBgColor: const Color(0xFFE1E2ED),
        badgeTextColor: const Color(0xFF434655),
      );
  }
}

class _StatusConfig {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final Color badgeBgColor;
  final Color badgeTextColor;

  const _StatusConfig({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.badgeBgColor,
    required this.badgeTextColor,
  });
}

import 'package:flutter/material.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/features/booking/presentation/pages/bookings_page.dart';
import 'package:shineup/features/explore/presentation/pages/explore_page.dart';
import 'package:shineup/features/home/presentation/pages/home_page.dart';
import 'package:shineup/features/profile/presentation/pages/profile_page.dart';
import 'package:shineup/features/main/presentation/widgets/bottom_nav_bar.dart';

/// The main shell that wraps all authenticated screens with a bottom navigation bar.
///
/// Uses [IndexedStack] to preserve the state of each tab when switching between them.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      HomePage(),
      ExplorePage(),
      BookingsPage(),
      ProfilePage(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final tabs = [
      BottomNavTab(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: t.navHome,
      ),
      BottomNavTab(
        icon: Icons.explore_outlined,
        activeIcon: Icons.explore,
        label: t.navExplore,
      ),
      BottomNavTab(
        icon: Icons.calendar_today_outlined,
        activeIcon: Icons.calendar_today,
        label: t.navBookings,
      ),
      BottomNavTab(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: t.navProfile,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        tabs: tabs,
      ),
    );
  }
}

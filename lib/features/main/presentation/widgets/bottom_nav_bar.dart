import 'package:flutter/material.dart';

/// Tab configuration for each item in the bottom navigation bar.
class BottomNavTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const BottomNavTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

/// Custom bottom navigation bar matching the Figma design.
///
/// Features:
/// - Height: 76px, background: #FAF8FF
/// - Top border radius: 32px
/// - Active tab gets a blue pill background (#2563EB) with white text
/// - Inactive tabs have grey text (#434655)
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavTab> tabs;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(tabs.length, (index) {
          final isActive = index == currentIndex;
          final tab = tabs[index];

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF2563EB)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isActive ? tab.activeIcon : tab.icon,
                      size: 18,
                      color: isActive
                          ? const Color(0xFFEEEFFF)
                          : const Color(0xFF434655),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tab.label,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: isActive
                            ? const Color(0xFFEEEFFF)
                            : const Color(0xFF434655),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

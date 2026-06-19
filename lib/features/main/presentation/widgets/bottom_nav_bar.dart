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
/// - Label animates in/out with [AnimatedSize] when tab becomes active/inactive
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
            flex:  isActive ? 3 :2,
            child: _NavItem(
              icon: isActive ? tab.activeIcon : tab.icon,
              label: tab.label,
              isActive: isActive,
              onTap: () => onTap(index),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color activeColor = Color(0xFFEEEFFF);
    const Color inactiveColor = Color(0xFF434655);

    final Color iconColor = isActive ? activeColor : inactiveColor;
    final Color pillBackground =
        isActive ? const Color(0xFF2563EB) : Colors.transparent;

    final double paddingHorizontal = isActive ? 16.0 : 8.0;
    const double paddingVertical = 4.0;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        decoration: BoxDecoration(
          color: pillBackground,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: iconColor),
            // Animate label appearance / disappearance
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: isActive
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: activeColor,
                          height: 1.5,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shinup/core/localization/app_localizations.dart';

class PrimaryActions extends StatelessWidget {
  const PrimaryActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      color: const Color(0xFFFAF8FF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ActionButton(icon: Icons.phone_rounded, label: AppLocalizations.of(context).providerActionCall),
          ActionButton(icon: Icons.navigation_rounded, label: AppLocalizations.of(context).providerActionDirections),
          ActionButton(icon: Icons.share_outlined, label: AppLocalizations.of(context).providerActionShare),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC3C6D7)),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {},
                child: Center(
                  child: Icon(icon, size: 20, color: const Color(0xFF004AC6)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 16 / 12,
              letterSpacing: 0.6,
              color: Color(0xFF191B23),
            ),
          ),
        ],
      ),
    );
  }
}

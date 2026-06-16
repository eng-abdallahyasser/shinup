import 'package:flutter/material.dart';

class AuthSocialButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Widget? iconWidget;
  final Color iconColor;
  final VoidCallback? onPressed;

  const AuthSocialButton({
    super.key,
    required this.text,
    this.icon,
    this.iconWidget,
    this.iconColor = const Color(0xFF191B23),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        side: const BorderSide(color: Color(0xFFC3C6D7)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconWidget != null)
            iconWidget!
          else if (icon != null)
            Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF191B23),
            ),
          ),
        ],
      ),
    );
  }
}

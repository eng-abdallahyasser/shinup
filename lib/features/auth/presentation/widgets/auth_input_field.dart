import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? prefixIconWidget;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const AuthInputField({
    super.key,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.prefixIconWidget,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0.6,
            color: Color(0xFF434655),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 57,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF8FF),
            border: Border.all(color: const Color(0xFFC3C6D7)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              if (prefixIconWidget != null)
                prefixIconWidget!
              else if (prefixIcon != null)
                Icon(prefixIcon, size: 20, color: const Color(0xFF737686)),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF191B23),
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                const SizedBox(width: 8),
                suffixIcon!,
                const SizedBox(width: 16),
              ] else
                const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}

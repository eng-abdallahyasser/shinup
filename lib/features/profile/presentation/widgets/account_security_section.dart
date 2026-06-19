import 'package:flutter/material.dart';
import 'package:shinup/features/profile/presentation/cubit/profile_cubit.dart';

class AccountSecuritySection extends StatelessWidget {
  final bool showOldPassword;
  final bool showNewPassword;
  final VoidCallback onToggleOldPassword;
  final VoidCallback onToggleNewPassword;
  final List<ActiveSession> sessions;
  final String accountSecurityLabel;
  final String updatePasswordLabel;
  final String currentPasswordHint;
  final String newPasswordHint;
  final String updatePasswordBtnLabel;
  final String activeSessionsLabel;
  final String currentLabel;
  final String agoLabel;

  const AccountSecuritySection({
    super.key,
    required this.showOldPassword,
    required this.showNewPassword,
    required this.onToggleOldPassword,
    required this.onToggleNewPassword,
    required this.sessions,
    required this.accountSecurityLabel,
    required this.updatePasswordLabel,
    required this.currentPasswordHint,
    required this.newPasswordHint,
    required this.updatePasswordBtnLabel,
    required this.activeSessionsLabel,
    required this.currentLabel,
    required this.agoLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            accountSecurityLabel.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
              color: Color(0xFF434655),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
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
              // Update password section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    updatePasswordLabel,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF191B23),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPasswordField(
                    hint: currentPasswordHint,
                    obscureText: !showOldPassword,
                    onToggle: onToggleOldPassword,
                  ),
                  const SizedBox(height: 8),
                  _buildPasswordField(
                    hint: newPasswordHint,
                    obscureText: !showNewPassword,
                    onToggle: onToggleNewPassword,
                  ),
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: () {
                      // Update password action
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      updatePasswordBtnLabel,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF004AC6),
                      ),
                    ),
                  ),
                ],
              ),
              // Divider
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Divider(
                  color: Color(0xFFC3C6D7),
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  activeSessionsLabel.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Color(0xFF434655),
                  ),
                ),
              ),
              // Sessions
              ...sessions.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        // Icon
                        SizedBox(
                          width: 24,
                          child: Icon(
                            s.isCurrent
                                ? Icons.laptop_mac_rounded
                                : Icons.phone_iphone_rounded,
                            size: 18,
                            color: const Color(0xFF737686),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Session info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.isCurrent
                                    ? '${s.device} · ${s.browser} · ${s.location}'
                                    : '${s.device} · ${s.browser}',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xFF191B23),
                                ),
                              ),
                              Text(
                                s.isCurrent
                                    ? currentLabel
                                    : '${s.timeAgo} $agoLabel',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: s.isCurrent
                                      ? const Color(0xFF006E2F)
                                      : const Color(0xFF434655),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String hint,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color(0xFF191B23),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Color(0xFF6B7280),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF004AC6)),
        ),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 20,
            color: const Color(0xFF737686),
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ),
    );
  }
}

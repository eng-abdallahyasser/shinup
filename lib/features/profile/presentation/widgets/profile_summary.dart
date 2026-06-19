import 'package:flutter/material.dart';

class ProfileSummary extends StatelessWidget {
  final String fullName;
  final String email;
  final String editProfileLabel;
  final VoidCallback onEditTap;

  const ProfileSummary({
    super.key,
    required this.fullName,
    required this.email,
    required this.editProfileLabel,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final initials = fullName.isNotEmpty
        ? fullName.split(' ').map((w) => w.isNotEmpty ? w[0] : '').take(2).join()
        : '?';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: Color(0xFF2563EB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF004AC6),
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.white, width: 4),
                    ),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            fullName,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF191B23),
            ),
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            email,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF434655),
            ),
          ),
          const SizedBox(height: 16),
          // Edit Profile button
          SizedBox(
            height: 42,
            child: OutlinedButton(
              onPressed: onEditTap,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFC3C6D7)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              child: Text(
                editProfileLabel,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF191B23),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

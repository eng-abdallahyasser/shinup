import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinup/core/localization/locale_cubit.dart';

class FooterActionsSection extends StatelessWidget {
  final String languageLabel;
  final String deleteAccountLabel;
  final String signOutLabel;
  final String versionLabel;
  final VoidCallback? onSignOut;

  const FooterActionsSection({
    super.key,
    required this.languageLabel,
    required this.deleteAccountLabel,
    required this.signOutLabel,
    required this.versionLabel,
    this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Language button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () => _showLanguagePicker(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFC3C6D7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            icon: const Icon(
              Icons.language_rounded,
              size: 20,
              color: Color(0xFF191B23),
            ),
            label: Text(
              languageLabel,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF191B23),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Delete Account button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () {
              // Delete account action
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFC3C6D7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: Color(0xFFBA1A1A),
            ),
            label: Text(
              deleteAccountLabel,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFFBA1A1A),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Sign Out button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: onSignOut,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFC3C6D7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            icon: const Icon(
              Icons.logout_rounded,
              size: 20,
              color: Color(0xFF434655),
            ),
            label: Text(
              signOutLabel,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF434655),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Version
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            versionLabel,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: Color(0xFF737686),
            ),
          ),
        ),
      ],
    );
  }

  void _showLanguagePicker(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    final currentLocale = localeCubit.state.locale.languageCode;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      backgroundColor: const Color(0xFFFAF8FF),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC3C6D7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  languageLabel,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xFF191B23),
                  ),
                ),
                const SizedBox(height: 24),
                // English option
                _LanguageOption(
                  language: 'English',
                  code: 'en',
                  isSelected: currentLocale == 'en',
                  onTap: () {
                    localeCubit.setLocale(const Locale('en'));
                    Navigator.pop(ctx);
                  },
                ),
                const SizedBox(height: 12),
                // Arabic option
                _LanguageOption(
                  language: 'العربية',
                  code: 'ar',
                  isSelected: currentLocale == 'ar',
                  onTap: () {
                    localeCubit.setLocale(const Locale('ar'));
                    Navigator.pop(ctx);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFFC3C6D7),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: isSelected
                    ? Colors.white
                    : const Color(0xFF191B23),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                size: 20,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}

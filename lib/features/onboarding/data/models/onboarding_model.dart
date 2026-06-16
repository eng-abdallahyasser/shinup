/// Represents a single onboarding step with its display data.
class OnboardingData {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String? badgeText;
  final String? badgeIcon;
  final bool badgeHighlight;

  const OnboardingData({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    this.badgeText,
    this.badgeIcon,
    this.badgeHighlight = false,
  });
}

import 'package:flutter/material.dart';
import 'package:shinup/core/routes/app_pages.dart';
import 'package:shinup/features/provider/presentation/widgets/bottom_cta.dart';
import 'package:shinup/features/provider/presentation/widgets/hero_image.dart';
import 'package:shinup/features/provider/presentation/widgets/primary_actions.dart';
import 'package:shinup/features/provider/presentation/widgets/profile_header.dart';
import 'package:shinup/features/provider/presentation/widgets/reviews_content.dart';
import 'package:shinup/features/provider/presentation/widgets/about_content.dart';
import 'package:shinup/features/provider/presentation/widgets/services_content.dart';

class ProviderDetailPage extends StatefulWidget {
  final String providerId;

  const ProviderDetailPage({super.key, required this.providerId});

  @override
  State<ProviderDetailPage> createState() => _ProviderDetailPageState();
}

class _ProviderDetailPageState extends State<ProviderDetailPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Scrollable content ──────────────────────────────
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 96),
              child: Column(
                children: [
                  const HeroImage(),
                  const ProfileHeader(),
                  const PrimaryActions(),
                  _buildTabBar(),
                  _buildTabContent(),
                ],
              ),
            ),

            // ── Sticky Bottom CTA ───────────────────────────────
            BottomCta(
              onBookNow: () {
                Navigator.of(context).pushNamed(AppRouter.bookingStep2);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return const ServicesContent();
      case 1:
        return const ReviewsContent();
      case 2:
        return const AboutContent();
      default:
        return const ServicesContent();
    }
  }

  Widget _buildTabBar() {
    const tabs = ['Services', 'Reviews', 'About'];
    return Container(
      height: 51,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF8FF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFC3C6D7)),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isActive = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: isActive
                      ? const Border(
                          bottom: BorderSide(
                            color: Color(0xFF004AC6),
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 24 / 16,
                      color: isActive
                          ? const Color(0xFF004AC6)
                          : const Color(0xFF434655),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

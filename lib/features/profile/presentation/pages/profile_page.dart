import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/constants/app_constants.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:shineup/features/profile/presentation/widgets/account_security_section.dart';
import 'package:shineup/features/profile/presentation/widgets/footer_actions_section.dart';
import 'package:shineup/features/profile/presentation/widgets/loyalty_section.dart';
import 'package:shineup/features/profile/presentation/widgets/personal_info_section.dart';
import 'package:shineup/features/profile/presentation/widgets/profile_summary.dart';
import 'package:shineup/features/profile/presentation/widgets/addresses_section.dart';
import 'package:shineup/features/profile/presentation/widgets/vehicles_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(sl())..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top App Bar ─────────────────────────────────────────────
            Container(
              width: double.infinity,
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xFFFAF8FF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.profileTitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF004AC6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Notification action
                    },
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.notifications_outlined,
                        size: 18,
                        color: Color(0xFF004AC6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable Body ─────────────────────────────────────────
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state.status == ProfileStatus.initial ||
                      state.status == ProfileStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF004AC6),
                      ),
                    );
                  }

                  if (state.status == ProfileStatus.error) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.signal_wifi_off_rounded,
                              size: 48,
                              color: Color(0xFF737686),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.errorMessage ?? 'Something went wrong',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Color(0xFF434655),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => context
                                  .read<ProfileCubit>()
                                  .loadProfile(),
                              icon: const Icon(Icons.refresh_rounded, size: 18),
                              label: const Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF004AC6),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section 1: Profile Summary
                        ProfileSummary(
                          fullName: state.fullName,
                          email: state.email,
                          avatarUrl: state.avatarUrl,
                          editProfileLabel: t.editProfile,
                          onEditTap: () => context
                              .read<ProfileCubit>()
                              .onToggleEditMode(),
                          onAvatarTap: () => context
                              .read<ProfileCubit>()
                              .uploadAvatar(),
                        ),
                        const SizedBox(height: 24),

                        // Section 2: Personal Info
                        PersonalInfoSection(
                          isEditing: state.isEditing,
                          fullName: state.fullName,
                          email: state.email,
                          phone: state.phone,
                          personalInfoLabel: t.personalInfo,
                          fullNameLabel: t.fullName,
                          emailAddressLabel: t.emailAddress,
                          phoneNumberLabel: t.phoneNumber,
                          editLabel: t.edit,
                          saveLabel: t.save,
                          onNameChanged: (v) => context
                              .read<ProfileCubit>()
                              .onUpdateFullName(v),
                          onEmailChanged: (v) => context
                              .read<ProfileCubit>()
                              .onUpdateEmail(v),
                          onPhoneChanged: (v) => context
                              .read<ProfileCubit>()
                              .onUpdatePhone(v),
                          onSave: () =>
                              context.read<ProfileCubit>().onSaveProfile(),
                        ),
                        const SizedBox(height: 24),

                        // Section 3: My Vehicles
                        VehiclesSection(
                          vehicles: state.vehicles,
                          myVehiclesLabel: t.myVehicles,
                          addVehicleLabel: t.addVehicle,
                          noVehiclesLabel: t.noVehicles,
                          onAddVehicle: () async {
                            final added = await Navigator.of(context)
                                .pushNamed(
                              AppRouter.addVehicle,
                            ) as bool?;
                            if (added == true && context.mounted) {
                              context.read<ProfileCubit>().loadProfile();
                            }
                          },
                          onEditCar: (vehicle) async {
                            final updated = await Navigator.of(context)
                                .pushNamed(
                              AppRouter.carDetail,
                              arguments: vehicle.id,
                            ) as bool?;
                            if (updated == true && context.mounted) {
                              context.read<ProfileCubit>().loadProfile();
                            }
                          },
                        ),
                        const SizedBox(height: 24),

                        // Section 3b: My Addresses
                        AddressesSection(
                          addresses: state.addresses,
                          myAddressesLabel: t.myAddresses,
                          addAddressLabel: t.addAddress,
                          noAddressesLabel: t.noAddresses,
                          onAddAddress: () async {
                            final added = await Navigator.of(context)
                                .pushNamed(
                              AppRouter.addAddress,
                            ) as bool?;
                            if (added == true && context.mounted) {
                              context.read<ProfileCubit>().loadProfile();
                            }
                          },
                          onEditAddress: (address) async {
                            final updated = await Navigator.of(context)
                                .pushNamed(
                              AppRouter.addressDetail,
                              arguments: address.id,
                            ) as bool?;
                            if (updated == true && context.mounted) {
                              context.read<ProfileCubit>().loadProfile();
                            }
                          },
                        ),
                        const SizedBox(height: 24),

                        // Section 4: Loyalty & Rewards
                        LoyaltySection(
                          points: state.points,
                          pointsLabel: state.pointsLabel,
                          pointsProgress: state.pointsProgress,
                          recentActivities: state.recentActivities,
                          loyaltyRewardsLabel: t.loyaltyRewards,
                          recentActivityLabel: t.recentActivity,
                          redeemLabel: t.redeemYourPoints,
                        ),
                        const SizedBox(height: 24),

                        // Section 5: Account Security
                        AccountSecuritySection(
                          showOldPassword: state.showOldPassword,
                          showNewPassword: state.showNewPassword,
                          onToggleOldPassword: () => context
                              .read<ProfileCubit>()
                              .onToggleOldPasswordVisibility(),
                          onToggleNewPassword: () => context
                              .read<ProfileCubit>()
                              .onToggleNewPasswordVisibility(),
                          sessions: state.sessions,
                          accountSecurityLabel: t.accountSecurity,
                          updatePasswordLabel: t.updatePassword,
                          currentPasswordHint: t.currentPassword,
                          newPasswordHint: t.newPassword,
                          updatePasswordBtnLabel: t.updatePasswordBtn,
                          activeSessionsLabel: t.activeSessions,
                          currentLabel: t.current,
                          agoLabel: t.ago,
                        ),
                        const SizedBox(height: 24),

                        // Section 6: Footer Actions
                        FooterActionsSection(
                          languageLabel: t.language,
                          deleteAccountLabel: t.deleteAccount,
                          signOutLabel: t.signOut,
                          versionLabel: '${t.version} ${AppConstants.appVersion}',
                          onSignOut: () async {
                            await context.read<ProfileCubit>().logout();
                            if (!context.mounted) return;
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRouter.login,
                              (_) => false,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

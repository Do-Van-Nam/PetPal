import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/main/ui/setting/bloc/setting_bloc.dart';
import 'package:demo_app/main/ui/setting/bloc/setting_event.dart';
import 'package:demo_app/main/ui/setting/bloc/setting_state.dart';
import 'package:demo_app/main/ui/setting/sections/profile_section.dart';
import 'package:demo_app/main/ui/setting/widgets/setting_group.dart';
import 'package:demo_app/main/ui/setting/widgets/setting_item.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc()..add(LoadSettingEvent()),
      child: const SettingView(),
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.color_FAFAF7,
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Column(
              children: [
                // ProfileSection(
                //   name: state.userName,
                //   email: state.userEmail,
                //   isPro: state.isProMember,
                // ),
                // const SizedBox(height: 32),
                SettingGroup(
                  title: l10n.account,
                  children: [
                    SettingItem(
                      icon: Icons.person_outline,
                      title: l10n.personalInformation,
                      iconBgColor: AppColors.color_FFB5C2,
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.pets_outlined,
                      title: l10n.myPets,
                      iconBgColor: AppColors.color_B3F2BA,
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.payment_outlined,
                      title: l10n.paymentMethods,
                      iconBgColor: AppColors.color_D1C7B5,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingGroup(
                  title: l10n.preferences,
                  children: [
                    SettingItem(
                      icon: Icons.notifications_none,
                      title: l10n.notifications,
                      iconBgColor: AppColors.color_FFB5C2,
                      trailing: Switch(
                        value: state.notificationsEnabled,
                        onChanged: (val) {
                          context
                              .read<SettingBloc>()
                              .add(UpdateNotificationEvent(val));
                        },
                        activeColor: AppColors.color_B3F2BA,
                      ),
                    ),
                    SettingItem(
                      icon: Icons.location_on_outlined,
                      title: l10n.locationServices,
                      iconBgColor: AppColors.color_B3F2BA,
                      trailing: Switch(
                        value: state.locationEnabled,
                        onChanged: (val) {
                          context
                              .read<SettingBloc>()
                              .add(UpdateLocationEvent(val));
                        },
                        activeColor: AppColors.color_B3F2BA,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingGroup(
                  title: l10n.support,
                  children: [
                    SettingItem(
                      icon: Icons.help_outline,
                      title: l10n.helpSupport,
                      iconBgColor: AppColors.color_D1C7B5,
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.privacy_tip_outlined,
                      title: l10n.privacyPolicy,
                      iconBgColor: AppColors.color_D1C7B5,
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.star_outline,
                      title: l10n.reviewOnStore,
                      iconBgColor: AppColors.color_FFB5C2,
                      onTap: () {
                        // TODO: Implement In-App Review
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.reviewOnStore)),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                _buildLogoutButton(context),
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.color_B3F2BA, width: 2),
            image: const DecorationImage(
              image: NetworkImage("https://placehold.co/40x40"),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'PetPal',
          style: TextStyle(
            color: AppColors.color_ED4799,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.color_FFD9D6,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.color_FFD9D6.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Text(
            l10n.logout,
            style: AppStyles.fredoka18Medium
                .copyWith(color: AppColors.color_94000A),
          ),
        ),
      ),
    );
  }
}

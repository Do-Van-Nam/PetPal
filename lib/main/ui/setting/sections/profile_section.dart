import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String name;
  final String email;
  final bool isPro;

  const ProfileSection({
    super.key,
    required this.name,
    required this.email,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.color_FFB5C2.withOpacity(0.15),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.color_B3F2BA, width: 4),
                  image: const DecorationImage(
                    image: NetworkImage("https://placehold.co/96x96"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.color_FFB5C2,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt,
                      color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(name, style: AppStyles.fredoka24SemiBold),
          const SizedBox(height: 4),
          Text(
            email,
            style: AppStyles.fredoka16Regular
                .copyWith(color: AppColors.color_524245),
          ),
          if (isPro) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.color_B3F2BA,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified,
                      size: 16, color: AppColors.color_367045),
                  const SizedBox(width: 4),
                  Text(
                    l10n.proMember,
                    style: AppStyles.fredoka14Medium
                        .copyWith(color: AppColors.color_367045),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconBgColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.iconBgColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: iconBgColor),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                title,
                style: AppStyles.fredoka18Medium.copyWith(
                  color: AppColors.color_1C1C1C,
                ),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.color_524245,
                ),
          ],
        ),
      ),
    );
  }
}

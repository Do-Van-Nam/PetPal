import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';

class ActivityGoalSection extends StatelessWidget {
  final double percentage;

  const ActivityGoalSection({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: [
          BoxShadow(
            color: AppColors.color_FFB5C2.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
            spreadRadius: -10,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            'ACTIVITY GOAL',
            style: AppStyles.fredoka14Medium.copyWith(
              color: AppColors.color_524245,
              letterSpacing: 0.70,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: percentage / 100,
                  strokeWidth: 12,
                  backgroundColor: AppColors.color_F5F2F2,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.color_874F59),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${percentage.toInt()}',
                    style: AppStyles.fredoka28Bold.copyWith(
                      fontSize: 40,
                      color: AppColors.color_874F59,
                    ),
                  ),
                  Text(
                    '%',
                    style: AppStyles.fredoka18Regular.copyWith(
                      color: AppColors.color_874F59,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            percentage >= 100 
                ? 'Goal achieved! Amazing job!'
                : 'Almost there! A little more playtime needed.',
            textAlign: TextAlign.center,
            style: AppStyles.fredoka16Regular.copyWith(
              color: AppColors.color_524245,
            ),
          ),
        ],
      ),
    );
  }
}

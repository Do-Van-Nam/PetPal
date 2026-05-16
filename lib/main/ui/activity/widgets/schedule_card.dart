import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ScheduleCard({
    super.key,
    required this.activity,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDone = activity.isDone ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isDone ? AppColors.color_FFB5C2 : Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color:
                      isDone ? AppColors.color_FFB5C2 : AppColors.color_D6C2C2,
                  width: 2,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onEdit,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.description,
                    style: AppStyles.fredoka16Medium.copyWith(
                      color: isDone
                          ? AppColors.color_A8A39E
                          : AppColors.color_1C1C1C,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    activity.parseDateToString(activity.date),
                    style: AppStyles.fredoka14Regular.copyWith(
                      color: isDone
                          ? AppColors.color_A8A39E
                          : AppColors.color_1C1C1C,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline,
                color: AppColors.color_874F59, size: 20),
          ),
        ],
      ),
    );
  }
}

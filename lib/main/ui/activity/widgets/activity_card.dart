import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDone = activity.isDone ?? false;

    return Row(
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
                color: isDone ? AppColors.color_FFB5C2 : AppColors.color_D6C2C2,
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
            child: Text(
              activity.description,
              style: AppStyles.fredoka16Medium.copyWith(
                color: isDone ? AppColors.color_A8A39E : AppColors.color_1C1C1C,
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline,
              color: AppColors.color_874F59, size: 20),
        ),
      ],
    );
  }
}

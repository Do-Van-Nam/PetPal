import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/main/ui/activity/bloc/activity_bloc.dart';
import 'package:demo_app/main/ui/activity/bloc/activity_event.dart';
import 'package:demo_app/main/ui/activity/widgets/activity_card.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyTasksSection extends StatelessWidget {
  final List<Activity> activities;
  final VoidCallback onAdd;

  const DailyTasksSection({
    super.key,
    required this.activities,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Tasks',
              style: AppStyles.fredoka24SemiBold,
            ),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle_outline,
                  color: Color(0xFF2F6A3F)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (activities.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'No daily tasks yet',
                style: AppStyles.fredoka14Medium.copyWith(color: Colors.grey),
              ),
            ),
          )
        else
          Container(
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
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ActivityCard(
                  activity: activity,
                  onToggle: () {
                    context
                        .read<ActivityBloc>()
                        .add(ToggleActivityDoneEvent(activity));
                  },
                  onDelete: () {
                    context
                        .read<ActivityBloc>()
                        .add(DeleteActivityEvent(activity.id));
                  },
                  onEdit: () {
                    // TODO: Implement edit
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

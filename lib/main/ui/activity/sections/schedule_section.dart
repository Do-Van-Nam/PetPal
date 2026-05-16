import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/main/ui/activity/bloc/activity_bloc.dart';
import 'package:demo_app/main/ui/activity/bloc/activity_event.dart';
import 'package:demo_app/main/ui/activity/widgets/activity_card.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/schedule_card.dart';

class ScheduleSection extends StatelessWidget {
  final List<Activity> activities;
  final VoidCallback onAdd;

  const ScheduleSection({
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
              'Schedules',
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
                'No schedules yet',
                style: AppStyles.fredoka14Medium.copyWith(color: Colors.grey),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ScheduleCard(
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
      ],
    );
  }
}

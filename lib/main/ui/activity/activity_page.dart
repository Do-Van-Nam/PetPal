import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/main/data/model/pet.dart';
import 'package:demo_app/main/data/database/pet_db_helper.dart';
import 'package:demo_app/main/ui/activity/bloc/activity_bloc.dart';
import 'package:demo_app/main/ui/activity/bloc/activity_event.dart';
import 'package:demo_app/main/ui/activity/bloc/activity_state.dart';
import 'package:demo_app/main/ui/activity/sections/activity_goal_section.dart';
import 'package:demo_app/main/ui/activity/sections/daily_tasks_section.dart';
import 'package:demo_app/main/ui/activity/sections/schedule_section.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(),
      child: const ActivityView(),
    );
  }
}

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  List<Pet> _pets = [];
  Pet? _selectedPet;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    final pets = await PetDbHelper.instance.loadAllPets();
    if (pets.isNotEmpty) {
      setState(() {
        _pets = pets;
        _selectedPet = pets.first;
      });
      if (mounted) {
        context
            .read<ActivityBloc>()
            .add(ActivityInitialized(_selectedPet!.id!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state.status == ActivityStatus.loading && _pets.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_pets.isEmpty) {
              return Center(
                child: Text(
                  'Please add a pet first!',
                  style: AppStyles.fredoka18Medium,
                ),
              );
            }

            // Calculate progress percentage
            final allActivities = [
              ...state.dailyActivities,
              ...state.schedules
            ];
            final doneCount =
                allActivities.where((a) => a.isDone == true).length;
            final percentage = allActivities.isEmpty
                ? 0.0
                : (doneCount / allActivities.length) * 100;

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<ActivityBloc>()
                    .add(ActivityInitialized(_selectedPet!.id!));
              },
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 12),
                    _buildPetSelector(),
                    const SizedBox(height: 32),
                    ActivityGoalSection(percentage: percentage),
                    const SizedBox(height: 40),
                    DailyTasksSection(
                      activities: state.dailyActivities,
                      onAdd: () =>
                          _showAddActivityDialog(context, ActivityType.daily),
                    ),
                    const SizedBox(height: 32),
                    ScheduleSection(
                      activities: state.schedules,
                      onAdd: () => _showAddScheduleDialog(
                          context, ActivityType.schedule),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activity & Schedule',
          style: AppStyles.fredoka28SemiBold.copyWith(
            color: AppColors.color_1C1C1C,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Keep track of your furry friend's day!",
          style: AppStyles.fredoka16Regular.copyWith(
            color: AppColors.color_524245,
          ),
        ),
      ],
    );
  }

  Widget _buildPetSelector() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _pets.length,
        itemBuilder: (context, index) {
          final pet = _pets[index];
          final isSelected = _selectedPet?.id == pet.id;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedPet = pet);
              context.read<ActivityBloc>().add(ActivityInitialized(pet.id!));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.color_FFB5C2
                    : AppColors.color_F5F2F2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                pet.name,
                style: AppStyles.fredoka14Medium.copyWith(
                  color: isSelected ? Colors.white : AppColors.color_524245,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context, ActivityType type) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add ${type == ActivityType.daily ? 'Daily Task' : 'Schedule'}',
                style: AppStyles.fredoka18SemiBold,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                style: AppStyles.fredoka16Medium,
                decoration: InputDecoration(
                  hintText: 'Enter activity description',
                  hintStyle: AppStyles.fredoka14Regular
                      .copyWith(color: AppColors.color_A8A39E),
                  filled: true,
                  fillColor: AppColors.color_F5F2F2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: AppColors.color_D6C2C2),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text('Cancel',
                          style: AppStyles.fredoka16Medium
                              .copyWith(color: AppColors.color_524245)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty &&
                            _selectedPet != null) {
                          final activity = Activity(
                            id: const Uuid().v4(),
                            petId: _selectedPet!.id!,
                            activityType: type,
                            description: controller.text,
                            isDone: false,
                            date: DateTime.now(),
                          );
                          context
                              .read<ActivityBloc>()
                              .add(AddActivityEvent(activity));
                          Navigator.pop(ctx);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color_FFB5C2,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text('Add', style: AppStyles.fredoka16Medium),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext parentContext, ActivityType type) {
    final controller = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (context, setDialogState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add ${type == ActivityType.daily ? 'Daily Task' : 'Schedule'}',
                  style: AppStyles.fredoka18SemiBold,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  autofocus: true,
                  style: AppStyles.fredoka16Medium,
                  decoration: InputDecoration(
                    hintText: 'Enter activity description',
                    hintStyle: AppStyles.fredoka14Regular
                        .copyWith(color: AppColors.color_A8A39E),
                    filled: true,
                    fillColor: AppColors.color_F5F2F2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setDialogState(() => selectedDate = date);
                          }
                        },
                        child: _buildPickerItem(
                          icon: Icons.calendar_today_outlined,
                          text: DateFormat('dd/MM/yyyy').format(selectedDate),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (time != null) {
                            setDialogState(() => selectedTime = time);
                          }
                        },
                        child: _buildPickerItem(
                          icon: Icons.access_time_outlined,
                          text: selectedTime.format(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          side: const BorderSide(color: AppColors.color_D6C2C2),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text('Cancel',
                            style: AppStyles.fredoka16Medium
                                .copyWith(color: AppColors.color_524245)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty &&
                              _selectedPet != null) {
                            final combinedDateTime = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                            final activity = Activity(
                              id: const Uuid().v4(),
                              petId: _selectedPet!.id!,
                              activityType: type,
                              description: controller.text,
                              isDone: false,
                              date: combinedDateTime,
                            );
                            parentContext
                                .read<ActivityBloc>()
                                .add(AddActivityEvent(activity));
                            Navigator.pop(ctx);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.color_FFB5C2,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Text('Add', style: AppStyles.fredoka16Medium),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPickerItem({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.color_F5F2F2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.color_524245),
          const SizedBox(width: 8),
          Text(text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.fredoka14Medium
                  .copyWith(color: AppColors.color_524245)),
        ],
      ),
    );
  }
}

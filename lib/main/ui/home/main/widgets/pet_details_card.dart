import 'dart:io';

import 'package:demo_app/main/data/model/pet.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:demo_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class PetDetailsCard extends StatelessWidget {
  const PetDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) => prev.selectedPet != curr.selectedPet,
      builder: (context, state) {
        final Pet? pet = state.selectedPet;
        if (pet == null) return const SizedBox.shrink();

        final String breedLabel = pet.breed?.displayName ?? pet.type.name;

        final String ageLabel =
            pet.birthday != null ? '${_calcAge(pet.birthday!)} years old' : '';

        final String subtitle =
            [breedLabel, ageLabel].where((s) => s.isNotEmpty).join(' • ');

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFF5F3F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x26FFB6C1),
                blurRadius: 40,
                offset: Offset(0, 15),
                spreadRadius: -15,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  Container(
                    width: 128,
                    height: 128,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEFEDED),
                      image:
                          (pet.avatarPath != null && pet.avatarPath!.isNotEmpty)
                              ? DecorationImage(
                                  image: FileImage(File(pet.avatarPath!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 4, color: AppColors.color_FFB5C2),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x332F6A3F),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: (pet.avatarPath == null || pet.avatarPath!.isEmpty)
                        ? const Icon(Icons.pets,
                            size: 48, color: Color(0xFFD6C2C3))
                        : null,
                  ),
                  const SizedBox(height: 24),
                  // Tên
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pet.name,
                        style: AppStyles.fredoka28SemiBold.copyWith(
                          color: const Color(0xFF1B1C1C),
                          height: 1.30,
                        ),
                      ),
                      if (pet.gender != PetGender.unknown)
                        Text(
                          pet.gender == PetGender.male ? ' ♂' : ' ♀',
                          style: AppStyles.fredoka14SemiBold.copyWith(
                            color: const Color(0xFF1B1C1C),
                            height: 1.30,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Giống & tuổi
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: AppStyles.fredoka18Regular.copyWith(
                        color: const Color(0xFF514345),
                        height: 1.60,
                      ),
                    ),
                  const SizedBox(height: 16),
                  // Tags
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTag(
                        pet.type.name,
                        const Color(0xFFFFB6C1),
                        const Color(0xFF7B444E),
                        icon: Icons.pets,
                      ),
                      if (pet.color != null && pet.color!.isNotEmpty)
                        _buildTag(
                          pet.color!,
                          AppColors.color_0F8CE8.withOpacity(0.15),
                          AppColors.color_0F8CE8,
                          icon: Icons.color_lens_outlined,
                        ),
                      if (pet.weight != null)
                        _buildTag(
                          "${pet.weight!.toString()} kg",
                          AppColors.color_630FE8.withOpacity(0.15),
                          AppColors.color_630FE8,
                          icon: Icons.scale_outlined,
                        ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: -12,
                right: -12,
                child: PopupMenuButton<int>(
                  icon: const Icon(Icons.more_horiz, color: Color(0xFF514345)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onSelected: (value) async {
                    if (value == 0) {
                      // Chỉnh sửa
                      final result =
                          await context.push(PATH_ADD_PET, extra: {"pet": pet});
                      if (result == true) {
                        context.read<HomeBloc>().add(HomeInitialized());
                      }
                    } else if (value == 1) {
                      // Xóa
                      _showDeleteConfirmationDialog(context, pet);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined,
                              color: Color(0xFF514345), size: 20),
                          SizedBox(width: 8),
                          Text('Chỉnh sửa'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline,
                              color: Colors.redAccent, size: 20),
                          SizedBox(width: 8),
                          Text('Xóa',
                              style: TextStyle(color: Colors.redAccent)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Pet pet) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Xác nhận xóa'),
        content: Text(
            'Bạn có chắc chắn muốn xóa ${pet.name} không? Mọi hình ảnh và kỷ niệm của bé sẽ bị xóa vĩnh viễn.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child:
                const Text('Hủy', style: TextStyle(color: Color(0xFF514345))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<HomeBloc>().add(DeletePetEvent(pet.id!));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor,
      {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppStyles.fredoka14Medium.copyWith(
              color: textColor,
              height: 1.20,
              letterSpacing: 0.28,
            ),
          ),
        ],
      ),
    );
  }

  int _calcAge(DateTime birthday) {
    final now = DateTime.now();
    int age = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }
}

import 'dart:io';

import 'package:demo_app/core/app_export.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class PetListSection extends StatelessWidget {
  final double scale;
  const PetListSection({super.key, this.scale = 1.0});

  double get _avatarSize => (80 * scale).clamp(48.0, 80.0);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: (4 * scale).clamp(2.0, 4.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Danh sách pets từ state
                ...state.pets.map((pet) => Padding(
                      padding: EdgeInsets.only(
                          right: (24 * scale).clamp(16.0, 24.0)),
                      child: GestureDetector(
                        onTap: () =>
                            context.read<HomeBloc>().add(SelectPetEvent(pet)),
                        child: _buildPetAvatar(
                          name: pet.name,
                          avatarPath: pet.avatarPath,
                          isSelected: state.selectedPet?.id == pet.id,
                        ),
                      ),
                    )),
                // Nút thêm pet
                _buildAddButton(
                  context,
                  l10n.add,
                  () => context.read<HomeBloc>().add(HomeInitialized()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPetAvatar({
    required String name,
    String? avatarPath,
    required bool isSelected,
  }) {
    final double opacity = isSelected ? 1.0 : 0.60;
    final Color borderColor =
        isSelected ? AppColors.color_FFB5C2 : const Color(0xFFD6C2C3);
    final double borderWidth = isSelected ? 4.0 : 2.0;

    // Dùng ảnh local nếu có, không thì dùng placeholder
    final ImageProvider imageProvider = (avatarPath != null &&
            avatarPath.isNotEmpty)
        ? FileImage(File(avatarPath))
        : const NetworkImage(
                'https://fagopet.vn/storage/in/r5/inr5f4qalj068szn2bs34qmv28r2_phoi-giong-meo-munchkin.webp')
            as ImageProvider;

    return Opacity(
      opacity: opacity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _avatarSize,
            height: _avatarSize,
            padding: const EdgeInsets.all(2),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: borderWidth, color: borderColor),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
          SizedBox(height: (3 * scale).clamp(2.0, 3.0)),
          Text(
            name,
            style: AppStyles.fredoka14Medium.copyWith(
              fontSize: (14 * scale).clamp(11.0, 14.0),
              color: isSelected
                  ? const Color(0xFF1B1C1C)
                  : const Color(0xFF514345),
              height: 1.20,
              letterSpacing: 0.28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(
      BuildContext context, String label, VoidCallback onReload) {
    return GestureDetector(
      onTap: () async {
        final result = await context.push(PATH_ADD_PET, extra: {"pet": null});
        if (result == true) {
          print("goi ham reload man home");
          onReload();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _avatarSize,
            height: _avatarSize,
            decoration: ShapeDecoration(
              color: const Color(0xFFFBF9F8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0xFFFFB6C1)),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: const Center(
              child: Icon(Icons.add, color: Color(0xFFFFB6C1)),
            ),
          ),
          SizedBox(height: (3 * scale).clamp(2.0, 3.0)),
          Text(
            label,
            style: AppStyles.fredoka14Medium.copyWith(
              fontSize: (14 * scale).clamp(11.0, 14.0),
              color: const Color(0xFF514345),
              height: 1.20,
              letterSpacing: 0.28,
            ),
          ),
        ],
      ),
    );
  }
}

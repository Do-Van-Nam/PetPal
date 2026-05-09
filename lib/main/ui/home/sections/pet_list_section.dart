import 'package:flutter/material.dart';
import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/res/app_styles.dart';

class PetListSection extends StatelessWidget {
  const PetListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPetAvatar(
              name: l10n.bella,
              imageUrl: "https://placehold.co/68x68",
              isSelected: true,
            ),
            const SizedBox(width: 24),
            _buildPetAvatar(
              name: l10n.luna,
              imageUrl: "https://placehold.co/72x72",
              isSelected: false,
            ),
            const SizedBox(width: 24),
            _buildPetAvatar(
              name: l10n.max,
              imageUrl: "https://placehold.co/72x72",
              isSelected: false,
            ),
            const SizedBox(width: 24),
            _buildAddButton(l10n.add),
          ],
        ),
      ),
    );
  }

  Widget _buildPetAvatar({
    required String name,
    required String imageUrl,
    required bool isSelected,
  }) {
    final double opacity = isSelected ? 1.0 : 0.60;
    final Color borderColor =
        isSelected ? const Color(0xFF2F6A3F) : const Color(0xFFD6C2C3);
    final double borderWidth = isSelected ? 4.0 : 2.0;

    return Opacity(
      opacity: opacity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
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
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            name,
            style: AppStyles.fredoka14Medium.copyWith(
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

  Widget _buildAddButton(String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
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
        const SizedBox(height: 3),
        Text(
          label,
          style: AppStyles.fredoka14Medium.copyWith(
            color: const Color(0xFF514345),
            height: 1.20,
            letterSpacing: 0.28,
          ),
        ),
      ],
    );
  }
}

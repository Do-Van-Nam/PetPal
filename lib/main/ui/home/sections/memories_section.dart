import 'package:flutter/material.dart';
import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/res/app_styles.dart';

class MemoriesSection extends StatelessWidget {
  const MemoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.memories,
              style: AppStyles.fredoka18Medium.copyWith(
                color: const Color(0xFF1B1C1C),
                height: 1.60,
              ),
            ),
            _buildPaginationDots(),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildSmallMemoryImage("https://placehold.co/165x165")),
            const SizedBox(width: 12),
            Expanded(child: _buildSmallMemoryImage("https://placehold.co/165x165")),
          ],
        ),
        const SizedBox(height: 12),
        _buildLargeMemoryImage("https://placehold.co/342x342", l10n.parkDay),
      ],
    );
  }

  Widget _buildPaginationDots() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: const Color(0xFFEFEDED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: ShapeDecoration(
              color: const Color(0xFFFBF9F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ],
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 16,
            height: 16,
            decoration: ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallMemoryImage(String imageUrl) {
    return Container(
      height: 165,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLargeMemoryImage(String imageUrl, String label) {
    return Container(
      width: double.infinity,
      height: 342,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withValues(alpha: 0.50), Colors.transparent],
            ),
          ),
          child: Text(
            label,
            style: AppStyles.fredoka14Medium.copyWith(
              color: Colors.white,
              height: 1.20,
              letterSpacing: 0.28,
            ),
          ),
        ),
      ),
    );
  }
}

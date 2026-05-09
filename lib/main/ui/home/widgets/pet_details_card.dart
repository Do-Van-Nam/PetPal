import 'package:demo_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/res/app_styles.dart';

class PetDetailsCard extends StatelessWidget {
  const PetDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -10, // Approximate positioning for the background blob
            top: -40,
            child: Opacity(
              opacity: 0.20,
              child: Container(
                width: 160,
                height: 160,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFD9DE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 128,
                height: 128,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage("https://placehold.co/128x128"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 4, color: Color(0xFFB2F2BB)),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x332F6A3F),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                      spreadRadius: -10,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.bella,
                style: AppStyles.fredoka28SemiBold.copyWith(
                  color: const Color(0xFF1B1C1C),
                  height: 1.30,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.goldenRetriever3YearsOld,
                textAlign: TextAlign.center,
                style: AppStyles.fredoka18Regular.copyWith(
                  color: const Color(0xFF514345),
                  height: 1.60,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTag(l10n.vaccinated, const Color(0xFFB2F2BB),
                      const Color(0xFF357044)),
                  _buildTag(l10n.friendly, const Color(0xFFFFB6C1),
                      const Color(0xFF7B444E)),
                  _buildTag(l10n.energetic, const Color(0xFFD2C8B5),
                      const Color(0xFF5A5445)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Text(
        label,
        style: AppStyles.fredoka14Medium.copyWith(
          color: textColor,
          height: 1.20,
          letterSpacing: 0.28,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/res/app_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const ShapeDecoration(
        color: Color(0xFFFFF9FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33FFB6C1),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                    spreadRadius: -10,
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage("https://placehold.co/48x48"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFF2F6A3F),
                    ),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Text(
                AppLocalizations.of(context)!.petPal,
                style: AppStyles.fredoka24Bold.copyWith(
                  color: const Color(0xFFEC4899),
                  fontWeight: FontWeight.w900,
                  height: 1.33,
                  letterSpacing: -1.20,
                ),
              ),
              const Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF5F3F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child:
                    const Icon(Icons.notifications_none, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

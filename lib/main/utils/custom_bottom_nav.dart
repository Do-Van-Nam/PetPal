import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_fonts.dart';
import 'package:demo_app/res/app_images.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: CustomPaint(painter: BottomNavPainter())),
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  child: _buildNavItem(
                    0,
                    0 == currentIndex
                        ? AppImages.icHomeActive
                        : AppImages.icHome,
                    AppLocalizations.of(context)!.petPal,
                  ),
                ),
                Expanded(
                  child: _buildNavItem(
                    1,
                    1 == currentIndex
                        ? AppImages.icActivityActive
                        : AppImages.icActivity,
                    AppLocalizations.of(context)!.petPal,
                  ),
                ),
                // Expanded(
                //   child: _buildNavItem(
                //     2,
                //     2 == currentIndex
                //         ? AppImages.icChatActive
                //         : AppImages.icChat,
                //     AppLocalizations.of(context)!.petPal,
                //   ),
                // ),
                Expanded(
                  child: _buildNavItem(
                    2,
                    2 == currentIndex
                        ? AppImages.icSettingActive
                        : AppImages.icSetting,
                    AppLocalizations.of(context)!.petPal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String icon, String label) {
    return _NavItem(
      index: index,
      icon: icon,
      label: label,
      isSelected: index == currentIndex,
      onTap: () => onTabSelected(index),
    );
  }
}

class _NavItem extends StatefulWidget {
  final int index;
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.elasticOut,
    );

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.85).animate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                widget.icon,
                colorFilter: ColorFilter.mode(
                  widget.isSelected
                      ? AppColors.color_ED4799
                      : AppColors.color_A8A39E,
                  BlendMode.srcIn,
                ),
              ),
              // const SizedBox(height: 4),
              // Text(
              //   widget.label,
              //   style: widget.isSelected
              //       ? AppStyles.fredoka11Medium.copyWith(
              //           fontSize: 10,
              //           color: AppColors.color_ED4799,
              //         )
              //       : AppStyles.fredoka11Regular.copyWith(
              //           fontSize: 10,
              //           color: AppColors.color_A8A39E,
              //         ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    const cornerRadius = 20.0;

    const iconSize = 60.0;
    const borderGap = 5.0;
    final cutRadius = iconSize / 2 + borderGap;

    final centerX = width / 2;

    final path = Path();

    path.moveTo(cornerRadius, 0);
    path.quadraticBezierTo(0, 0, 0, cornerRadius);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, cornerRadius);
    path.quadraticBezierTo(width, 0, width - cornerRadius, 0);
    path.lineTo(centerX + cutRadius, 0);

    path.lineTo(cornerRadius, 0);
    path.close();

    canvas.drawShadow(path, Colors.black26, 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

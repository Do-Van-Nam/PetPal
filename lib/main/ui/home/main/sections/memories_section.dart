import 'dart:io';

import 'package:demo_app/core/app_export.dart';
import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/main/data/model/photo.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class MemoriesSection {
  static List<Widget> buildSlivers(BuildContext context, HomeState state) {
    final l10n = AppLocalizations.of(context)!;
    final List<Photo> photos = state.photos;
    final bool isGridView = state.isGridView;
    void onTapPhoto(String photoId) async {
      final result =
          await context.push(PATH_PHOTO_DETAIL, extra: {'photoId': photoId});
      if (result != null && result is bool && result) {
        context.read<HomeBloc>().add(HomeInitialized());
      }
    }

    return [
      SliverPersistentHeader(
        pinned: true,
        delegate: _MemoriesHeaderDelegate(
          child: Container(
            color: Colors.white, // Bền nền để ảnh trượt bên dưới không bị đè
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.memories,
                  style: AppStyles.fredoka18Medium.copyWith(
                    color: const Color(0xFF1B1C1C),
                    height: 1.60,
                  ),
                ),
                if (photos.isNotEmpty) _buildViewToggle(context, isGridView),
              ],
            ),
          ),
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      if (photos.isEmpty)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(child: _buildEmptyState(l10n)),
        )
      else if (isGridView)
        _buildSliverGrid(photos, onTapPhoto)
      else
        _buildSliverList(photos, onTapPhoto),
    ];
  }

  // ─── View Toggle ─────────────────────────────────────────────────────────────

  static Widget _buildViewToggle(BuildContext context, bool isGridView) {
    return GestureDetector(
      onTap: () {
        context.read<HomeBloc>().add(ToggleMemoriesViewEvent(!isGridView));
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          isGridView ? AppImages.icList2 : AppImages.icGrid,
          height: 24,
          width: 24,
        ),
      ),
    );
  }

  static Widget _buildToggleButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 40,
        ),
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          shadows: isActive
              ? [
                  const BoxShadow(
                    color: Color(0x192F6A3F),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 12,
            color: isActive ? const Color(0xFF2F6A3F) : const Color(0xFFAFA2A4),
          ),
        ),
      ),
    );
  }

  // ─── Empty State ─────────────────────────────────────────────────────────────

  static Widget _buildEmptyState(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F3F3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.photo_library_outlined,
              size: 40, color: Color(0xFFD6C2C3)),
          const SizedBox(height: 12),
          Text(
            l10n.noMemoriesYet,
            style: AppStyles.fredoka14Medium.copyWith(
              color: const Color(0xFF514345),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sliver Grid View ────────────────────────────────────────────────────────

  static Widget _buildSliverGrid(
      List<Photo> photos, Function(String photoId) onTapPhoto) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 ô vuông cạnh nhau
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1, // Hình vuông
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final photo = photos[index];
          return GestureDetector(
              onTap: () => onTapPhoto(photo.id),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _imageProvider(photo.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ));
        },
        childCount: photos.length,
      ),
    );
  }

  // ─── Sliver List View ────────────────────────────────────────────────────────

  static Widget _buildSliverList(
      List<Photo> photos, Function(String photoId) onTapPhoto) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final photo = photos[index];
            final String dateStr = _timeAgo(photo.createdAt ?? DateTime.now());

            return GestureDetector(
              onTap: () => onTapPhoto(photo.id),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 200,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  image: DecorationImage(
                    image: _imageProvider(photo.path),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            photo.caption ?? '',
                            style: AppStyles.fredoka14Medium.copyWith(
                              color: Colors.white,
                              height: 1.20,
                              letterSpacing: 0.28,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          dateStr,
                          style: AppStyles.fredoka14Medium.copyWith(
                            color: Colors.white70,
                            height: 1.20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: photos.length,
        ),
      ),
    );
  }

  // ─── Helper ──────────────────────────────────────────────────────────────────

  static ImageProvider _imageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    }
    return FileImage(File(path));
  }

  static String _timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inDays >= 365) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else if (diff.inDays >= 30) {
      final months = (diff.inDays / 30).floor();
      return '$months tháng trước';
    } else if (diff.inDays >= 7) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks tuần trước';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} ngày trước';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} giờ trước';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}

class _MemoriesHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _MemoriesHeaderDelegate({required this.child});

  @override
  double get minExtent => 45.0;

  @override
  double get maxExtent => 45.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _MemoriesHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}

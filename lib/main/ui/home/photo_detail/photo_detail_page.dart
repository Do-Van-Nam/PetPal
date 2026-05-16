import 'dart:io';

import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:share_plus/share_plus.dart';

import 'bloc/photo_detail_bloc.dart';
import 'bloc/photo_detail_event.dart';
import 'bloc/photo_detail_state.dart';

class PhotoDetailPage extends StatelessWidget {
  final String photoId;

  const PhotoDetailPage({super.key, required this.photoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoDetailBloc()..add(LoadPhotoEvent(photoId)),
      child: const _PhotoDetailView(),
    );
  }
}

class _PhotoDetailView extends StatefulWidget {
  const _PhotoDetailView();

  @override
  State<_PhotoDetailView> createState() => _PhotoDetailViewState();
}

class _PhotoDetailViewState extends State<_PhotoDetailView> {
  final TextEditingController _captionController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _captionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoDetailBloc, PhotoDetailState>(
      listenWhen: (prev, curr) {
        // If entering edit mode, populate controller
        if (!prev.isEditing && curr.isEditing) {
          _captionController.text = curr.editedCaption;
          _focusNode.requestFocus();
        }
        return false;
      },
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == PhotoDetailStatus.loading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: CircularProgressIndicator(color: Color(0xFF2F6A3F))),
          );
        }

        if (state.status == PhotoDetailStatus.failure || state.photo == null) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () => context.pop(state.didEdit),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            body: const Center(child: Text("Không thể tải ảnh")),
          );
        }

        final photo = state.photo!;
        final dateStr = DateFormat('dd/MM/yyyy HH:mm')
            .format(photo.createdAt ?? DateTime.now());

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              PopupMenuButton<int>(
                icon: const Icon(Icons.more_horiz, color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onSelected: (value) async {
                  if (value == 0) {
                    // Share
                    Share.shareXFiles(
                      [XFile(state.photo!.path)],
                      text: state.photo!.caption,
                    );
                  } else if (value == 1) {
                    // Delete
                    final confirm = await _showDeleteConfirmation(context);
                    if (confirm == true) {
                      if (context.mounted) {
                        context.read<PhotoDetailBloc>().add(DeletePhotoEvent());
                        // Trả về true để trang trước biết là đã xóa
                        context.pop(true);
                      }
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.share_outlined,
                            color: Colors.black54, size: 20),
                        SizedBox(width: 8),
                        Text('Chia sẻ'),
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
                        Text('Xóa ảnh',
                            style: TextStyle(color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ảnh kích thước gốc sát 2 bên màn hình
                Image(
                  image: _imageProvider(photo.path),
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    dateStr,
                    style:
                        AppStyles.fredoka14Medium.copyWith(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: state.isEditing
                      ? _buildEditCaption(context)
                      : _buildCaptionDisplay(context, state.editedCaption),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCaptionDisplay(BuildContext context, String caption) {
    return GestureDetector(
      onTap: () {
        context.read<PhotoDetailBloc>().add(ToggleEditCaptionEvent());
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.transparent, // Để dễ click
        child: Text(
          caption.isEmpty ? "Chạm để thêm chú thích..." : caption,
          style: AppStyles.fredoka16Medium.copyWith(
            color: caption.isEmpty ? Colors.grey : const Color(0xFF514345),
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildEditCaption(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: _captionController,
          focusNode: _focusNode,
          maxLines: null,
          style: AppStyles.fredoka16Medium
              .copyWith(color: const Color(0xFF514345)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF2F6A3F)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF2F6A3F), width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
            hintText: "Nhập chú thích...",
          ),
          onChanged: (val) {
            context.read<PhotoDetailBloc>().add(UpdateCaptionTextEvent(val));
          },
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            context.read<PhotoDetailBloc>().add(SavePhotoCaptionEvent());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F6A3F),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text("Lưu"),
        ),
      ],
    );
  }

  ImageProvider _imageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    }
    return FileImage(File(path));
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa bức ảnh này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:
                const Text('Hủy', style: TextStyle(color: Color(0xFF514345))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
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
}

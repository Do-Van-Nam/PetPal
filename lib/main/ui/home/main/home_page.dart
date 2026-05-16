import 'dart:io';

import 'package:demo_app/main/utils/widget/app_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';
import 'widgets/home_header.dart';
import 'sections/memories_section.dart';
import 'widgets/pet_details_card.dart';
import 'sections/pet_list_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeInitialized()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = _scrollController.hasClients
        ? (1.0 - _scrollController.offset / 120).clamp(0.65, 1.0)
        : 1.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        // Chỉ lắng nghe khi trạng thái lỗi thay đổi HOẶC khi có ảnh mới được chọn
        listenWhen: (prev, curr) =>
            (curr.status == HomeStatus.failure &&
                prev.status != HomeStatus.failure) ||
            (curr.pickedPhoto != null &&
                curr.pickedPhoto?.path != prev.pickedPhoto?.path),
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            AppToast.show(context, 'Có lỗi xảy ra, vui lòng thử lại');
          }
          if (state.pickedPhoto != null) {
            _showAddMemoryBottomSheet(context, state);
          }
        },
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                const HomeHeader(),
                SizedBox(
                  height: (112 * scale).clamp(78.0, 112.0),
                  child: PetListSection(scale: scale),
                ),
                Expanded(
                  child: _buildBody(context, state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    // Loading
    if (state.status == HomeStatus.loading && state.pets.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2F6A3F)),
      );
    }

    // Empty — chưa có pet nào
    if (state.status == HomeStatus.success && state.pets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pets, size: 64, color: Color(0xFFD6C2C3)),
            const SizedBox(height: 16),
            Text(
              'Chưa có thú cưng nào',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF514345),
                  ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                // TODO: Navigate to Add Pet screen
              },
              icon: const Icon(Icons.add, color: Color(0xFF2F6A3F)),
              label: const Text(
                'Thêm thú cưng',
                style: TextStyle(color: Color(0xFF2F6A3F)),
              ),
            ),
          ],
        ),
      );
    }

    // Success — có dữ liệu
    // Success — có dữ liệu
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
          sliver: SliverToBoxAdapter(
            child: PetDetailsCard(),
          ),
        ),
        ...MemoriesSection.buildSlivers(context, state),
        const SliverToBoxAdapter(
          child: SizedBox(height: 120), // Padding cho bottom navigation bar
        ),
      ],
    );
  }

  void _showAddMemoryBottomSheet(BuildContext context, HomeState state) {
    // Lưu lại bloc để sử dụng trong bottom sheet
    final bloc = context.read<HomeBloc>();
    final captionController = TextEditingController();
    String? selectedPetId = state.selectedPet?.id;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thêm kỉ niệm mới',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1B1C1C),
                          ),
                    ),
                    const SizedBox(height: 24),
                    // Hiển thị ảnh vừa chọn
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: FileImage(File(state.pickedPhoto!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Dropdown chọn pet
                    if (state.pets.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F3F3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPetId,
                            isExpanded: true,
                            hint: const Text('Chọn thú cưng'),
                            items: state.pets.map((pet) {
                              return DropdownMenuItem(
                                value: pet.id,
                                child: Text(pet.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setBottomSheetState(() {
                                  selectedPetId = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    // Nhập caption
                    TextField(
                      controller: captionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Nhập mô tả cho bức ảnh này...',
                        filled: true,
                        fillColor: const Color(0xFFF5F3F3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: selectedPetId == null
                            ? null
                            : () {
                                bloc.add(
                                  SavePhotoEvent(
                                    petId: selectedPetId!,
                                    caption: captionController.text,
                                    imagePath: state.pickedPhoto!.path,
                                  ),
                                );
                                Navigator.pop(bottomSheetContext);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6A3F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Lưu kỉ niệm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      // Gọi khi bottom sheet đóng (cả khi lưu và khi dismiss)
      bloc.add(ClearPickedPhotoEvent());
    });
  }
}

import 'dart:io';

import 'package:demo_app/generated/app_localizations.dart';
import 'package:demo_app/main/data/model/pet.dart';
import 'package:demo_app/res/app_colors.dart';
import 'package:demo_app/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/add_pet_bloc.dart';
import 'bloc/add_pet_event.dart';
import 'bloc/add_pet_state.dart';

class AddPetPage extends StatelessWidget {
  final Pet? pet;
  const AddPetPage({super.key, this.pet});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddPetBloc(initialPet: pet)..add(InitPetEvent(pet)),
      child: _AddPetView(pet: pet),
    );
  }
}

class _AddPetView extends StatefulWidget {
  final Pet? pet;
  const _AddPetView({this.pet});

  @override
  State<_AddPetView> createState() => _AddPetViewState();
}

class _AddPetViewState extends State<_AddPetView> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _colorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pet != null) {
      _nameController.text = widget.pet!.name;
      _weightController.text = widget.pet!.weight.toString();
      _colorController.text = widget.pet!.color ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AddPetBloc, AddPetState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == AddPetStatus.success) {
          context.pop(true);
        } else if (state.status == AddPetStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorOccurred)),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<AddPetBloc>();
        return Scaffold(
          backgroundColor: const Color(0xFFFFFAFA),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFFAFA),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFF1B1C1C)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              widget.pet != null ? l10n.editPetInfo : l10n.addPet,
              style: AppStyles.fredoka18Medium.copyWith(
                color: const Color(0xFF1B1C1C),
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── 1. Avatar ────────────────────────────────────────────────
                      _buildAvatarPicker(context, state, bloc),
                      const SizedBox(height: 32),

                      // ── 2. Tên thú cưng ──────────────────────────────────────────
                      _buildSectionLabel(l10n.petName),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _nameController,
                        hint: l10n.enterPetName,
                        onChanged: (v) => bloc.add(NameChangedEvent(v)),
                      ),
                      const SizedBox(height: 24),

                      // ── 3. Loài ───────────────────────────────────────────────────
                      _buildSectionLabel(l10n.species),
                      const SizedBox(height: 12),
                      _buildPetTypeGrid(context, state, bloc, l10n),
                      const SizedBox(height: 24),

                      // ── 4. Giống ──────────────────────────────────────────────────
                      _buildSectionLabel(l10n.breed),
                      const SizedBox(height: 8),
                      _buildBreedDropdown(context, state, bloc, l10n),
                      const SizedBox(height: 24),

                      // ── 5. Giới tính ──────────────────────────────────────────────
                      _buildSectionLabel(l10n.gender),
                      const SizedBox(height: 8),
                      _buildGenderRow(context, state, bloc, l10n),
                      const SizedBox(height: 24),

                      // ── 6. Ngày sinh ──────────────────────────────────────────────
                      _buildSectionLabel(l10n.birthday),
                      const SizedBox(height: 8),
                      _buildBirthdayPicker(context, state, bloc, l10n),
                      const SizedBox(height: 24),

                      // ── 7. Cân nặng ───────────────────────────────────────────────
                      _buildSectionLabel(l10n.weightKg),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _weightController,
                        hint: l10n.weightHint,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                        ],
                        onChanged: (v) => bloc.add(WeightChangedEvent(v)),
                      ),
                      const SizedBox(height: 24),

                      // ── 8. Màu lông ───────────────────────────────────────────────
                      _buildSectionLabel(l10n.petColor),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _colorController,
                        hint: l10n.colorHint,
                        onChanged: (v) => bloc.add(ColorChangedEvent(v)),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              // ── Nút lưu ───────────────────────────────────────────────────
              _buildSaveButton(context, state, bloc, l10n),
              // const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // AVATAR PICKER
  // ════════════════════════════════════════════════════════════════════════════

  Widget _buildAvatarPicker(
      BuildContext context, AddPetState state, AddPetBloc bloc) {
    return Center(
      child: GestureDetector(
        onTap: () => bloc.add(PickAvatarEvent()),
        child: Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: ShapeDecoration(
                color: const Color(0xFFEFEDED),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 3, color: Color(0xFFFFB6C1)),
                  borderRadius: BorderRadius.circular(9999),
                ),
                image: state.avatarPath != null
                    ? DecorationImage(
                        image: FileImage(File(state.avatarPath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: state.avatarPath == null
                  ? const Icon(Icons.pets, size: 48, color: Color(0xFFD6C2C3))
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 34,
                height: 34,
                decoration: const ShapeDecoration(
                  color: AppColors.color_FFB5C2,
                  shape: CircleBorder(),
                ),
                child:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // PET TYPE GRID
  // ════════════════════════════════════════════════════════════════════════════

  Map<PetType, _TypeMeta> _getTypeMeta(AppLocalizations l10n) {
    return {
      PetType.dog: _TypeMeta('🐶', l10n.dog),
      PetType.cat: _TypeMeta('🐱', l10n.cat),
      PetType.bird: _TypeMeta('🐦', l10n.bird),
      PetType.rabbit: _TypeMeta('🐰', l10n.rabbit),
      PetType.hamster: _TypeMeta('🐹', l10n.hamster),
      PetType.guineaPig: _TypeMeta('🐷', l10n.guineaPig),
      PetType.fish: _TypeMeta('🐟', l10n.fish),
      PetType.turtle: _TypeMeta('🐢', l10n.turtle),
      PetType.snake: _TypeMeta('🐍', l10n.snake),
      PetType.lizard: _TypeMeta('🦎', l10n.lizard),
      PetType.hedgehog: _TypeMeta('🦔', l10n.hedgehog),
      PetType.ferret: _TypeMeta('🦡', l10n.ferret),
      PetType.rat: _TypeMeta('🐭', l10n.rat),
      PetType.frog: _TypeMeta('🐸', l10n.frog),
      PetType.other: _TypeMeta('🐾', l10n.other),
    };
  }

  Widget _buildPetTypeGrid(BuildContext context, AddPetState state,
      AddPetBloc bloc, AppLocalizations l10n) {
    final typeMeta = _getTypeMeta(l10n);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemCount: PetType.values.length,
      itemBuilder: (_, i) {
        final type = PetType.values[i];
        final meta = typeMeta[type]!;
        final isSelected = state.selectedType == type;

        return GestureDetector(
          onTap: () => bloc.add(PetTypeSelectedEvent(type)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3F3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 2,
                color: isSelected
                    ? AppColors.color_FFB5C2
                    : const Color(0xFFEFEDED),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(meta.emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 4),
                Text(
                  meta.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF514345),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // BREED DROPDOWN
  // ════════════════════════════════════════════════════════════════════════════

  Widget _buildBreedDropdown(BuildContext context, AddPetState state,
      AddPetBloc bloc, AppLocalizations l10n) {
    final breeds = state.availableBreeds;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFEDED)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PetBreed>(
          value: state.selectedBreed,
          isExpanded: true,
          hint: Text(l10n.selectBreed),
          borderRadius: BorderRadius.circular(16),
          items: breeds
              .map((b) => DropdownMenuItem(
                    value: b,
                    child: Text(b.getLocalizedName(l10n)),
                  ))
              .toList(),
          onChanged: (breed) {
            if (breed != null) bloc.add(PetBreedSelectedEvent(breed));
          },
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // GENDER ROW
  // ════════════════════════════════════════════════════════════════════════════

  Widget _buildGenderRow(BuildContext context, AddPetState state,
      AddPetBloc bloc, AppLocalizations l10n) {
    final genders = [
      (PetGender.male, '♂', l10n.male, const Color(0xFF5799FF)),
      (PetGender.female, '♀', l10n.female, const Color(0xFFED4799)),
      (PetGender.unknown, '?', l10n.unknown, const Color(0xFFA8A39E)),
    ];

    return Row(
      children: genders.map((g) {
        final isSelected = state.gender == g.$1;
        return Expanded(
          child: GestureDetector(
            onTap: () => bloc.add(GenderSelectedEvent(g.$1)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? g.$4.withValues(alpha: 0.15) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? g.$4 : const Color(0xFFEFEDED),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Text(g.$2,
                      style: TextStyle(
                          fontSize: 22,
                          color: isSelected ? g.$4 : const Color(0xFFA8A39E))),
                  const SizedBox(height: 4),
                  Text(g.$3,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? g.$4 : const Color(0xFFA8A39E))),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // BIRTHDAY PICKER
  // ════════════════════════════════════════════════════════════════════════════

  Widget _buildBirthdayPicker(BuildContext context, AddPetState state,
      AddPetBloc bloc, AppLocalizations l10n) {
    final label = state.birthday != null
        ? '${state.birthday!.day}/${state.birthday!.month}/${state.birthday!.year}'
        : l10n.selectBirthday;

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: state.birthday ??
              DateTime.now().subtract(const Duration(days: 365)),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme:
                  const ColorScheme.light(primary: AppColors.color_FFB5C2),
            ),
            child: child!,
          ),
        );
        if (picked != null) bloc.add(BirthdayPickedEvent(picked));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEFEDED)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 18, color: Color(0xFFA8A39E)),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: state.birthday != null
                    ? const Color(0xFF1B1C1C)
                    : const Color(0xFFA8A39E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ════════════════════════════════════════════════════════════════════════════

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: AppStyles.fredoka14Medium.copyWith(
        color: const Color(0xFF1B1C1C),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFA8A39E), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEFEDED)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEFEDED)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.color_FFB5C2, width: 2),
        ),
      ),
    );
  }

  Widget _buildSaveButton(
      BuildContext context, AddPetState state, AddPetBloc bloc, l10n) {
    final isLoading = state.status == AddPetStatus.loading;

    return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: state.isValid && !isLoading
                ? () => bloc.add(SavePetEvent())
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.color_FFB5C2,
              disabledBackgroundColor: const Color(0xFFD6C2C3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  )
                : Text(
                    l10n.savePet,
                    style: AppStyles.fredoka18Medium.copyWith(
                      color: Colors.white,
                    ),
                  ),
          ),
        ));
  }
}

// ── Helper class ─────────────────────────────────────────────────────────────

class _TypeMeta {
  final String emoji;
  final String label;
  const _TypeMeta(this.emoji, this.label);
}

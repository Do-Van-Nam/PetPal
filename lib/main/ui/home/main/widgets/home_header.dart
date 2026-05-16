import 'package:demo_app/core/app_export.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
      ),
      child: Row(
        children: [
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
          GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(LibraryTapEvent());
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(AppImages.icLibrary),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(CameraTapEvent());
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(AppImages.icCam),
            ),
          ),
        ],
      ),
    );
  }
}

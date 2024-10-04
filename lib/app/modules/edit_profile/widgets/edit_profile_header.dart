import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:pokedex_app/app/modules/edit_profile/widgets/edit_profile_photo.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EditProfilePhoto(),
        TextButton(
          onPressed: () async {
            final picker = ImagePicker();
            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 50,
            );

            if (image != null) {
              //debugPrint(image.name);
              context.read<EditProfileCubit>().changeImage(bytes: await image.readAsBytes());
            }
          },
          child: Text(
            'Change Photo',
            style: CustomTheme.pokedexLabels.copyWith(
              decorationColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

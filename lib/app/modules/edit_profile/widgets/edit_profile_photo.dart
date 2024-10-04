import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/edit_profile/cubit/edit_profile_cubit.dart';

class EditProfilePhoto extends StatelessWidget {
  const EditProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
        ),
        child: Container(
          height: 150,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: BlocSelector<EditProfileCubit, EditProfileState, List<dynamic>>(
            selector: (state) {
              if (state is EditProfileFetch) {
                final user = state.user;
                return [
                  user.blobImage,
                  state.bytes,
                ];
              }
              return [];
            },
            builder: (context, list) {
              if (list.isNotEmpty) {
                final blobImage = list[0];
                final bytes = list[1];

                if (bytes != null) {
                  return Image.memory(
                    bytes,
                  );
                } else {
                  if (blobImage != null) {
                    Uint8List newImageBytes = const Base64Decoder().convert(blobImage);
                    return Image.memory(
                      newImageBytes,
                    );
                  }
                }
                return const SizedBox.shrink();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

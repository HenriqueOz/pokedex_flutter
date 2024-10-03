import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/user_model.dart';
import 'package:pokedex_app/app/repositories/profile_repository.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepository _profileRepository;

  EditProfileCubit({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(
          EditProfileInit(),
        );

  void loadUser({required UserModel user}) async {
    final regiosList = await _profileRepository.getRegions();

    emit(
      EditProfileFetch(
        user: user,
        bytes: null,
        regionList: regiosList,
      ),
    );
  }

  void updateUser({required String name, required String region}) {}

  void changeImage({required Uint8List? bytes}) {
    final currentState = state;

    if (currentState is EditProfileFetch) {
      emit(
        EditProfileFetch(
          user: currentState.user.copyWith(blobImage: null),
          bytes: bytes,
          regionList: currentState.regionList,
        ),
      );
    }
  }
}

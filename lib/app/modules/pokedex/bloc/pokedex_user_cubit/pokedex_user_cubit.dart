import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/models/user_model.dart';
import 'package:pokedex_app/app/repositories/profile_repository.dart';

part 'pokedex_user_states.dart';

class PokedexUserCubit extends Cubit<PokedexUserStates> {
  final ProfileRepository _profileRepository;

  PokedexUserCubit({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(PokedexUserInit());

  void fetchUser() async {
    try {
      final model = await _profileRepository.getUser();
      emit(PokedexUserFetch(userModel: model));
    } on MessageException catch (e) {
      emit(PokedexUserError(message: e.message));
    }
  }
}

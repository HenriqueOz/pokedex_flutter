import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_app/app/models/user_model.dart';
import 'package:pokedex_app/app/modules/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:pokedex_app/app/modules/edit_profile/edit_profile_page.dart';
import 'package:pokedex_app/app/repositories/profile_repository.dart';
import 'package:provider/provider.dart';

class EditProfileModule {
  static Route pageBuilder({required RouteSettings? settings, required UserModel user}) {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      settings: settings,
      child: MultiBlocProvider(
        providers: [
          Provider(
            create: (context) => ProfileRepository(sqliteDatabase: context.read()),
          ),
          Provider(
            create: (context) => EditProfileCubit(profileRepository: context.read())..loadUser(user: user),
          )
        ],
        child: EditProfilePage(user: user),
      ),
    );
  }
}

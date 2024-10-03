import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/user_model.dart';
import 'package:pokedex_app/app/modules/edit_profile/widgets/edit_profile_app_bar.dart';
import 'package:pokedex_app/app/modules/edit_profile/widgets/edit_profile_bottom.dart';
import 'package:pokedex_app/app/modules/edit_profile/widgets/edit_profile_header.dart';

class EditProfilePage extends StatelessWidget {
  final UserModel user;

  const EditProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomTheme.primaryColor,
            // Color.fromARGB(255, 248, 107, 107),
            Colors.grey.shade800,
          ],
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        appBar: EditProfileAppBar(),
        body: Column(
          children: [
            EditProfileHeader(),
            SizedBox(height: 20),
            EditProfileBottom(),
          ],
        ),
      ),
    );
  }
}

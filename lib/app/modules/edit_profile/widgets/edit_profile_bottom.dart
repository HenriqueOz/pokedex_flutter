import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:pokedex_app/app/modules/edit_profile/widgets/edit_profile_form.dart';

class EditProfileBottom extends StatelessWidget {
  const EditProfileBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              blurRadius: 10,
            )
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BlocSelector<EditProfileCubit, EditProfileState, List<dynamic>>(
          selector: (state) {
            if (state is EditProfileFetch) {
              return [
                state.user.name,
                state.user.region,
                state.regionList,
              ];
            }

            return [];
          },
          builder: (context, list) {
            if (list.isNotEmpty) {
              return EditProfileForm(
                name: list[0] as String,
                region: list[1] as String,
                regionList: list[2] as List<String>,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

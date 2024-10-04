import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/core/ui/messenger.dart';
import 'package:pokedex_app/app/modules/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:pokedex_app/app/modules/edit_profile/widgets/edit_profile_dropdown.dart';
import 'package:pokedex_app/app/modules/edit_profile/widgets/edit_profile_name_input.dart';

class EditProfileForm extends StatefulWidget {
  final String name;
  final String region;
  final List<String> regionList;

  const EditProfileForm({super.key, required this.name, required this.region, required this.regionList});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _regionController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _regionController = TextEditingController(text: widget.region);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Divider(
                color: CustomTheme.primaryColor,
                height: 40,
                indent: 50,
                endIndent: 50,
                thickness: 1,
              ),
              const SizedBox(height: 30),
              EditProfileNameInput(
                controller: _nameController,
              ),
              const SizedBox(
                height: 40,
              ),
              EditProfileDropdown(controller: _regionController, regionsList: widget.regionList),
              const SizedBox(
                height: 80,
              ),
              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState?.validate() ?? false;

                  if (isValid) {
                    context.read<EditProfileCubit>().updateUser(
                          name: _nameController.text,
                          region: _regionController.text,
                        );

                    Messenger.of(context).showMessage(
                      'Profile edited',
                      Colors.white,
                      CustomTheme.primaryColor,
                    );
                    Navigator.pop(context);
                  }
                },
                style: CustomTheme.primaryButton,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

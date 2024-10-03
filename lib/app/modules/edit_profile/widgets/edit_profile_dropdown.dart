import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class EditProfileDropdown extends StatelessWidget {
  final TextEditingController controller;
  final List<String> regionsList;

  const EditProfileDropdown({super.key, required this.controller, required this.regionsList});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: controller,
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      label: const Text('Region'),
      menuHeight: 200,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: CustomTheme.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        constraints: const BoxConstraints(
          maxHeight: 50,
          maxWidth: 140,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        isDense: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      dropdownMenuEntries: [
        for (var region in regionsList) DropdownMenuEntry(value: region, label: region),
      ],
    );
  }
}

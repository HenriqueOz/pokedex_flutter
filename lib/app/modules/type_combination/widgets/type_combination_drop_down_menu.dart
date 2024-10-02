import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class TypeCombinationDropDownMenu extends StatelessWidget {
  final String label;
  final List<String> typeList;
  final bool? isSecondaryType;
  final void Function(String?)? onSelected;

  const TypeCombinationDropDownMenu({
    super.key,
    this.isSecondaryType = false,
    required this.label,
    required this.typeList,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      onSelected: onSelected,
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      menuHeight: 200,
      label: Text(label),
      textAlign: TextAlign.center,
      hintText: 'Type',
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: CustomTheme.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: false,
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
        const DropdownMenuEntry(value: '', label: 'empty'),
        for (var type in typeList) DropdownMenuEntry(value: type, label: type),
      ],
    );
  }
}

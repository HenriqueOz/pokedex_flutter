import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class PokedexSearchInput extends StatefulWidget {
  const PokedexSearchInput({super.key});

  @override
  State<PokedexSearchInput> createState() => _PokedexSearchInputState();
}

class _PokedexSearchInputState extends State<PokedexSearchInput> {
  final _searchEC = TextEditingController();

  @override
  void dispose() {
    _searchEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      controller: _searchEC,
      decoration: InputDecoration(
        hintText: 'Pokemon Name',
        hintStyle: CustomTheme.hint,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.all(12),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: CustomTheme.primaryColor,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _searchEC.clear();
          },
          icon: const Icon(
            Icons.clear,
            size: 20,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_search_bloc/pokedex_search_bloc.dart';

class PokedexSearchInput extends StatefulWidget {
  const PokedexSearchInput({super.key});

  @override
  State<PokedexSearchInput> createState() => _PokedexSearchInputState();
}

class _PokedexSearchInputState extends State<PokedexSearchInput> {
  String currentText = '';

  final _searchEC = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _searchEC.addListener(() {
          if (_searchEC.text != currentText) {
            currentText = _searchEC.text;
            context.read<PokedexSearchBloc>().add(PokedexSearchFindName(name: currentText));
          }
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _searchEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      'a',
      'b',
      'c',
      'd',
    ];

    return TypeAheadField<String>(
      builder: (context, controller, focusNode) {
        return TextField(
          onTapOutside: (event) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          controller: controller,
          focusNode: focusNode,
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
                controller.clear();
              },
              icon: const Icon(
                Icons.clear,
                size: 20,
              ),
            ),
          ),
        );
      },
      itemBuilder: (context, name) {
        return ListTile(
          title: Text(name),
        );
      },
      onSelected: (name) {},
      suggestionsCallback: (search) {
        return list;
      },
    );
  }
}

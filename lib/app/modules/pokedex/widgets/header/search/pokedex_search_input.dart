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
  String currentText = ''; //* armazena o texto atual co controller
  final _searchEC = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        //* disparando uma pesquisa vazia para a criação a lista
        _searchEC.addListener(_searchListener);
        context.read<PokedexSearchBloc>().add(PokedexSearchFindName(name: ''));
      },
    );
    super.initState();
  }

  void _searchListener() {
    if (_searchEC.text != currentText) {
      //* sempre que meu controller tiver uma string diferente da minha atual
      currentText = _searchEC.text; //* atualizo minha string atual
      //* dispara um evento de busca no blocv
      context.read<PokedexSearchBloc>().add(PokedexSearchFindName(name: currentText));
    }
  }

  @override
  void dispose() {
    _searchEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _searchEC.clear();

    //* recebendo a lista de nomes do state no bloc
    return BlocSelector<PokedexSearchBloc, PokedexSearchState, List<String>>(
      selector: (state) {
        if (state is PokedexSearchFetch) {
          return state.list;
        }
        return [];
      },
      builder: (context, list) {
        //* input de pesquisa
        return TypeAheadField<String>(
          controller: _searchEC,
          //* caixa de autocomplete
          decorationBuilder: (context, child) {
            return Material(
              type: MaterialType.card,
              elevation: 10,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              child: child,
            );
          },
          errorBuilder: (context, error) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'An error have occurred',
              style: CustomTheme.body,
            ),
          ),
          emptyBuilder: (context) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Nothing found',
              style: CustomTheme.body,
            ),
          ),
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
          //* itens da lista
          itemBuilder: (context, name) {
            return ListTile(
              title: Text(name),
            );
          },
          onSelected: (name) {
            _searchEC.text = name; //* quando eu seleciono uma opção meu input fica com a string dela
          },
          suggestionsCallback: (search) {
            return list; //* atualizando a lista para a atual
          },
        );
      },
    );
  }
}

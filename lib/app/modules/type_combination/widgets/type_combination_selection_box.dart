import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/type_combination/cubit/type_combination_cubit.dart';
import 'package:pokedex_app/app/modules/type_combination/widgets/type_combination_drop_down_menu.dart';

class TypeCombinationSelectionBox extends StatelessWidget {
  const TypeCombinationSelectionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocSelector<TypeCombinationCubit, TypeCombinationState, TypeCombinationFetch>(
        selector: (state) {
          return state as TypeCombinationFetch;
        },
        builder: (context, state) {
          final List<String> typeList = state.typeList;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TypeCombinationDropDownMenu(
                onSelected: (value) {
                  context.read<TypeCombinationCubit>().setPrimaryType(type: value);
                },
                label: 'Primary Type',
                typeList: typeList,
              ),
              const SizedBox(width: 20),
              TypeCombinationDropDownMenu(
                onSelected: (value) {
                  context.read<TypeCombinationCubit>().setSecondaryType(type: value);
                },
                isSecondaryType: true,
                label: 'Secondary Type',
                typeList: typeList,
              ),
            ],
          );
        },
      ),
    );
  }
}

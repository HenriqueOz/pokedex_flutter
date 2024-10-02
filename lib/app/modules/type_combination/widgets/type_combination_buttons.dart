import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/type_combination/cubit/type_combination_cubit.dart';

class TypeCombinationGenerateButton extends StatelessWidget {
  const TypeCombinationGenerateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<TypeCombinationCubit>().generateChart();
          },
          style: CustomTheme.primaryButton.copyWith(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.all(15),
            ),
          ),
          child: const Text('Generate Chart'),
        ),
      ],
    );
  }
}

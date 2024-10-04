import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_type_chart_calc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_types.dart';

part 'type_combination_state.dart';

class TypeCombinationCubit extends Cubit<TypeCombinationState> {
  String? _primaryType;
  String? _secondaryType;

  TypeCombinationCubit() : super(TypeCombinationInit());

  void reloadList() {
    final currentState = state;

    List<Map<String, double>> typeChart = [];
    if (currentState is TypeCombinationFetch) {
      typeChart = currentState.typeChart;
    }

    final List<String> typeList = PokemonTypes.types.where((type) {
      return type != _primaryType && type != _secondaryType;
    }).toList();

    emit(
      TypeCombinationFetch(
        typeList: typeList,
        typeChart: typeChart,
      ),
    );
  }

  void setPrimaryType({required String? type}) {
    if (type != null) {
      if (type.isNotEmpty) {
        _primaryType = type;
      } else {
        _primaryType = null;
      }
    } else {
      _primaryType = null;
    }
    reloadList();
  }

  void setSecondaryType({required String? type}) {
    if (type != null) {
      if (type.isNotEmpty) {
        _secondaryType = type;
      } else {
        _secondaryType = null;
      }
    } else {
      _secondaryType = null;
    }

    reloadList();
  }

  void generateChart() {
    if (_primaryType != null || _secondaryType != null) {
      //debugPrint('primary: $_primaryType secondary: $_secondaryType');
      final typeChart = PokemonTypeChartCalc.calcTypeChart(
        primaryType: _primaryType,
        secondaryType: _secondaryType,
      );

      final currentState = state;
      if (currentState is TypeCombinationFetch) {
        //debugPrint(typeChart.toString());
        emit(
          TypeCombinationFetch(
            typeList: currentState.typeList,
            typeChart: typeChart,
          ),
        );
      }
    } else {
      final currentState = state;
      if (currentState is TypeCombinationFetch) {
        emit(
          TypeCombinationFetch(
            typeList: currentState.typeList,
            typeChart: [],
          ),
        );
      }
    }
  }
}

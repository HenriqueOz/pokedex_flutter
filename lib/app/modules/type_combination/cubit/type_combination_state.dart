part of 'type_combination_cubit.dart';

abstract class TypeCombinationState {}

class TypeCombinationInit extends TypeCombinationState {}

class TypeCombinationFetch extends TypeCombinationState {
  final List<String> typeList;
  final List<Map<String, double>> typeChart;

  TypeCombinationFetch({
    required this.typeList,
    required this.typeChart,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_type_chart_calc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/cubit/pokemon_view_cubit/pokemon_view_cubit.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/tabs/tab_description.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/tabs/tab_evolution.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/tabs/tab_forms.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/tabs/tab_stats.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/tabs/tab_type_chart.dart';

class PokemonInfoTabBar extends StatefulWidget {
  final Color primaryColor;
  final Color? secondaryColor;
  final PokemonInfoModel data;
  final PokemonModel mainModel;

  const PokemonInfoTabBar({super.key, required this.mainModel, required this.primaryColor, required this.secondaryColor, required this.data});

  @override
  State<PokemonInfoTabBar> createState() => _PokemonInfoTabBar();
}

class _PokemonInfoTabBar extends State<PokemonInfoTabBar> with TickerProviderStateMixin {
  final List<Tab> tabs = [
    const Tab(child: Text('Description')),
    const Tab(child: Text('Stats')),
    const Tab(child: Text('Evolution')),
    const Tab(child: Text('Forms')),
    const Tab(child: Text('Type Chart')),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<PokemonViewCubit>().changeTab(tab: _tabController.index, length: _tabController.length);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          tabs: tabs,
          unselectedLabelColor: Colors.grey,
          labelColor: widget.primaryColor,
          dividerColor: Colors.transparent,
          indicatorColor: widget.primaryColor,
          isScrollable: true,
          labelStyle: CustomTheme.body,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        BlocSelector<PokemonViewCubit, PokemonViewState, int>(
          selector: (state) {
            if (state is PokemonViewData) {
              return state.tab;
            }
            return 0;
          },
          builder: (context, index) {
            final data = widget.data;

            return IndexedStack(
              index: index,
              children: [
                Visibility(
                  visible: index == 0,
                  child: TabDescription(
                    description: data.description,
                    cries: data.cries,
                    primaryColor: widget.primaryColor,
                    secondaryColor: widget.secondaryColor ?? widget.primaryColor,
                  ),
                ),
                Visibility(
                  visible: index == 1,
                  child: TabStats(
                    stats: data.stats,
                    primaryColor: widget.primaryColor,
                    secondaryColor: widget.secondaryColor ?? widget.primaryColor,
                  ),
                ),
                Visibility(
                  visible: index == 2,
                  child: TabEvolution(
                    mainModel: widget.mainModel,
                    primaryColor: widget.primaryColor,
                    list: data.evolutionChain,
                  ),
                ),
                Visibility(
                  visible: index == 3,
                  child: TabForms(
                    mainModel: widget.mainModel,
                    list: data.forms,
                    primaryColor: widget.primaryColor,
                  ),
                ),
                Visibility(
                  visible: index == 4,
                  child: TabTypeChart(
                    primaryColor: widget.mainModel.primaryColor!,
                    typeChartList: PokemonTypeChartCalc.calcTypeChart(
                      primaryType: widget.mainModel.typePrimary,
                      secondaryType: widget.mainModel.typeSecondary,
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';
import 'package:pokedex_app/app/modules/pokemon/cubit/pokemon_view_cubit.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/tabs/tab_description.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/tabs/tab_stats.dart';

class PokemonInfoTabBar extends StatefulWidget {
  final Color primaryColor;
  final Color? secondaryColor;
  final PokemonInfoModel data;

  const PokemonInfoTabBar({super.key, required this.primaryColor, required this.secondaryColor, required this.data});

  @override
  State<PokemonInfoTabBar> createState() => _PokemonInfoTabBar();
}

class _PokemonInfoTabBar extends State<PokemonInfoTabBar> with TickerProviderStateMixin {
  final List<Tab> tabs = [
    const Tab(child: Text('Description')),
    const Tab(child: Text('Stats')),
    const Tab(child: Text('Forms')),
    const Tab(child: Text('Weaknesses')),
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
                TabDescription(
                  description: data.description,
                  cries: data.cries,
                  primaryColor: widget.primaryColor,
                  secondaryColor: widget.secondaryColor ?? widget.primaryColor,
                ),
                TabStats(
                  stats: data.stats,
                  primaryColor: widget.primaryColor,
                  secondaryColor: widget.secondaryColor ?? widget.primaryColor,
                ),
                Container(child: const Text('ccccccccccccccccc')),
                Container(child: const Text('ddddddddddddddddd')),
                Container(child: const Text('fffffffffffffffff')),
              ],
            );
          },
        )
      ],
    );
  }
}

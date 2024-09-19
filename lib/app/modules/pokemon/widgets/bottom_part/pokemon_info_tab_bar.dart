import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokemon/cubit/pokemon_view_cubit.dart';

class PokemonInfoTabBar extends StatefulWidget {
  final Color color;

  const PokemonInfoTabBar({super.key, required this.color});

  @override
  State<PokemonInfoTabBar> createState() => _PokemonInfoTabBar();
}

class _PokemonInfoTabBar extends State<PokemonInfoTabBar> with TickerProviderStateMixin {
  final List<Tab> tabs = [
    const Tab(child: Text('Stats')),
    const Tab(child: Text('Description')),
    const Tab(child: Text('Cries')),
    const Tab(child: Text('Abilities')),
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
          labelColor: widget.color,
          dividerColor: Colors.transparent,
          indicatorColor: widget.color,
          isScrollable: true,
          labelStyle: CustomTheme.body,
        ),
        BlocSelector<PokemonViewCubit, PokemonViewState, int>(
          selector: (state) {
            if (state is PokemonViewData) {
              return state.tab;
            }
            return 0;
          },
          builder: (context, index) {
            return IndexedStack(
              index: index,
              children: [
                Container(child: const Text('aaaaaaaaaaaaaaaaa')),
                Container(child: const Text('bbbbbbbbbbbbbbbbb')),
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

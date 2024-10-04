import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/user_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_user_cubit/pokedex_user_cubit.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/drawer/pokedex_drawer_button.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/drawer/pokedex_drawer_header.dart';

class PokedexDrawer extends StatefulWidget {
  const PokedexDrawer({super.key});

  @override
  State<PokedexDrawer> createState() => _PokedexDrawerState();
}

class _PokedexDrawerState extends State<PokedexDrawer> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<PokedexUserCubit>().fetchUser();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(),
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [
            //* Header do drawer
            const PokedexDrawerHeader(),
            //* opções do drawer
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    BlocSelector<PokedexUserCubit, PokedexUserStates, UserModel>(selector: (state) {
                      if (state is PokedexUserFetch) {
                        return state.userModel;
                      }
                      return UserModel.empty();
                    }, builder: (context, user) {
                      return PokedexDrawerButton(
                        routeName: '/edit_profile/',
                        label: 'Edit Profile',
                        iconData: Icons.edit,
                        arguments: user,
                      );
                    }),
                    const PokedexDrawerButton(routeName: '/favorites/', label: 'Favorites', iconData: Icons.favorite),
                    const PokedexDrawerButton(routeName: '/type_combination/', label: 'Type Combination', iconData: Icons.add_circle_outline_sharp),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

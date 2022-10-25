import 'buisness_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';
import 'data/repo/characters_repo.dart';
import 'data/web_services/chracters_web_services.dart';
import 'presnation/pages/characters_detailes_screen.dart';
import 'presnation/pages/characters_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  //1
  late CharactersRepoistery charactersRepoistery;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepoistery = CharactersRepoistery(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepoistery);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => CharactersCubit(charactersRepoistery),
              child: CharactersDetailesScreen(character: character)),
        );
    }
  }
}

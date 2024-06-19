// ignore_for_file: body_might_complete_normally_nullable, unreachable_switch_case
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/business_logic/cubit/cubit/characters_cubit.dart';
import 'package:flutter_rick_and_morty/core/constants/string.dart';
import 'package:flutter_rick_and_morty/data/model/characters_model.dart';
import 'package:flutter_rick_and_morty/data/repo/characters_repo.dart';
import 'package:flutter_rick_and_morty/presentation/screen/character_screen.dart';
import 'package:flutter_rick_and_morty/presentation/screen/characters_details_screen.dart';

import '../../data/web_services/characters_web_services.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    characterRepository = CharacterRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharacterScreen(),
          ),
        );
      case charactersDetailsScreen:
        final charachter = settings.arguments as CharactersModel;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(
            characters: charachter,
          ),
        );
    }
  }
}

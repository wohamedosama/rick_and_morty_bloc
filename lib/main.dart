import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/data/web_services/characters_web_services.dart';
import 'core/routes/app_routers.dart';

void main() {
  CharactersWebServices charactersWebServices = CharactersWebServices();
  charactersWebServices.getAllCharacters();
  runApp(
    RickAndMorty(
      appRouter: AppRouter(),
    ),
  );
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({
    super.key,
    required this.appRouter,
  });
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

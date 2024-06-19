import '../model/characters_model.dart';
import '../web_services/characters_web_services.dart';

class CharacterRepository {
  final CharactersWebServices charactersWebServices;
  CharacterRepository(this.charactersWebServices);
  Future<List<CharactersModel>> getAllChracters() async {
    final List<dynamic> characters =
        await charactersWebServices.getAllCharacters();

    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }
}

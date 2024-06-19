import 'package:flutter_bloc/flutter_bloc.dart';
import 'characters_state.dart';
import '../../../data/model/characters_model.dart';
import '../../../data/repo/characters_repo.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository charactersRepository;
  List<CharactersModel> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<CharactersModel> getAllCharacters() {
    charactersRepository.getAllChracters().then(
      (characters) {
        emit(CharactersLoadedState(characters));
        this.characters = characters;

        //print(characters);
      },
    );

    return characters;
  }
}

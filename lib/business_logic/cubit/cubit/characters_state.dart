import '../../../data/model/characters_model.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final List<CharactersModel> characters;

  CharactersLoadedState(this.characters);
}

class CharactersErrorState extends CharactersState {}

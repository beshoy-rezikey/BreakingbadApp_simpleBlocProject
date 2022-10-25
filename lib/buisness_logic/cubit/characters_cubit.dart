import 'characters_state.dart';
import '../../data/models/quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters.dart';
import '../../data/repo/characters_repo.dart';

class CharactersCubit extends Cubit<CharactersState> {
  //1
  final CharactersRepoistery charactersRepoistery;
  List<Character> characters = [];
  CharactersCubit(this.charactersRepoistery) : super(CharactersInitial());
  List<Character> getAllCharaCters() {
    charactersRepoistery.getAllCharaCters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charactername) {
    charactersRepoistery.getCharactersQuotes(charactername).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}

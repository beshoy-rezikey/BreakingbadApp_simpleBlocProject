import '../models/characters.dart';
import '../models/quote.dart';
import '../web_services/chracters_web_services.dart';

//1
class CharactersRepoistery {
  //2
  final CharactersWebServices charactersWebServices;

  CharactersRepoistery(this.charactersWebServices);

  Future<List<Character>> getAllCharaCters() async {
    //3
    final characters = await charactersWebServices.getAllCharaCters();
    //4
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharactersQuotes(String charactername) async {
    //3
    final quote =
        await charactersWebServices.getCharactersQuotes(charactername);
    //4
    return quote.map((charQuote) => Quote.fromJson(charQuote)).toList();
  }
}

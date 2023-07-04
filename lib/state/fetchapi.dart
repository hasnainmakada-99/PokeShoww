import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_showw/models/PokeHub.dart';
import 'package:http/http.dart' as http;

class PokemonClient {
  final http.Client client;
  PokemonClient(this.client);
  Future<String> fetchPokemon() async {
    final response = await client.get(
      Uri.parse(
          'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch pokemons');
    }
  }
}

final pokemonClientProvider = Provider<PokemonClient>((ref) {
  return PokemonClient(http.Client());
});

final pokemonProvider = FutureProvider<String>((ref) async {
  final pokemonClient = ref.read(pokemonClientProvider);
  return await pokemonClient.fetchPokemon();
});

final pokeHubProvider = Provider<PokeHub>(
  (ref) {
    final jsonString = ref.watch(pokemonProvider).value;
    if (jsonString != null) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return PokeHub.fromJson(json);
    } else {
      throw Exception('Failed to parse Pokemon data');
    }
  },
);

class FavoritePokemonsNotifier extends StateNotifier<List<Pokemon>> {
  FavoritePokemonsNotifier() : super([]);

  void toggleFavorite(Pokemon pokemon) {
    if (state.contains(pokemon)) {
      state = List.from(state)..remove(pokemon);
    } else {
      state = List.from(state)..add(pokemon);
    }
  }
}

final favoritePokemonsProvider =
    StateNotifierProvider<FavoritePokemonsNotifier, List<Pokemon>>((ref) {
  return FavoritePokemonsNotifier();
});

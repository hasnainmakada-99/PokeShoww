import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:poke_showw/screens/PokemonDetail.dart';
import 'package:poke_showw/state/fetchapi.dart';

class FavoritePokemonsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePokemons = ref.watch(favoritePokemonsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Pokemons'),
      ),
      body: favoritePokemons.length == null
          ? Center(
              child: Text(
                'No Favourite Pokemons',
                style: TextStyle(fontSize: 35),
              ),
            )
          : ListView.builder(
              itemCount: favoritePokemons.length,
              itemBuilder: (context, index) {
                final pokemon = favoritePokemons[index];
                return ListTile(
                  leading: Image.network(pokemon.img!),
                  title: Text(pokemon.name!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetail(pokemon: pokemon),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

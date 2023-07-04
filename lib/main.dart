import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:poke_showw/screens/AddPokemon.dart';
import 'package:poke_showw/screens/FavouritePokemon.dart';

import 'package:poke_showw/screens/PokemonDetail.dart';
import 'package:poke_showw/state/fetchapi.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokeShoww',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Pokemons(),
    );
  }
}

class Pokemons extends ConsumerStatefulWidget {
  const Pokemons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PokemonsState();
}

class _PokemonsState extends ConsumerState<Pokemons> {
  @override
  Widget build(BuildContext context) {
    final pokeHub = ref.watch(pokeHubProvider);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('PokeShoww'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.scrolldroll.com/wp-content/uploads/2021/04/pokemon-Best-Cartoon-Shows-in-India.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Text(''),
              ),
              ListTile(
                title: const Text(
                  'Top Trending pokemons',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Pokemons(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: pokeHub.pokemon == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                crossAxisCount: 2,
                children: pokeHub.pokemon!
                    .map(
                      (poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PokemonDetail(pokemon: poke),
                              ),
                            );
                          },
                          child: Hero(
                            tag: poke.name.toString(),
                            child: Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          poke.img.toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    poke.name.toString(),
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPokemon(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
          child: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePokemonsScreen(),
                ),
              );
            },
          ),
        ));
  }
}

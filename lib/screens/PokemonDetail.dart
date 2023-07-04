import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_showw/models/PokeHub.dart';

import '../state/fetchapi.dart';

class PokemonDetail extends ConsumerStatefulWidget {
  final Pokemon pokemon;
  const PokemonDetail({super.key, required this.pokemon});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends ConsumerState<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.pokemon.name}'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: widget.pokemon.name.toString(),
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.pokemon.img.toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.pokemon.name.toString(),
                    style: const TextStyle(
                        fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Height: ${widget.pokemon.height}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Weight: ${widget.pokemon.weight}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Types",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type!
                        .map(
                          (t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {},
                          ),
                        )
                        .toList(),
                  ),
                  const Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses!
                        .map(
                          (t) => FilterChip(
                            backgroundColor: Colors.red,
                            label: Text(
                              t,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onSelected: (b) {},
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(favoritePokemonsProvider.notifier)
              .toggleFavorite(widget.pokemon);
        },
        child: Icon(
          widget.pokemon.isFavorite
              ? Icons.favorite_sharp
              : Icons.favorite_border,
        ),
      ),
    );
  }
}

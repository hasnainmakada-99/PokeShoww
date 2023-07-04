import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../main.dart';

class AddPokemon extends StatefulWidget {
  @override
  _AddPokemonState createState() => _AddPokemonState();
}

class _AddPokemonState extends State<AddPokemon> {
  final uuid = const Uuid();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> newPokemon = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Pokemon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller1,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller2,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller3,
                decoration: const InputDecoration(
                  labelText: 'Height',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller4,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final name = controller1.text;
                  final image = controller2.text;
                  final height = controller3.text;
                  final weight = controller4.text;
                  final id = const Uuid().v1();
                  newPokemon.add(id);
                  newPokemon.add(name);
                  newPokemon.add(image);
                  newPokemon.add(height);
                  newPokemon.add(weight);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("New Pokemon Added Successfully"),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pokemons(),
                    ),
                  );
                  print(newPokemon);
                },
                child: const Text('Add Pokemon'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

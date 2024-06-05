import 'package:alerta_dengue/models/diseases.dart';
import 'package:alerta_dengue/models/geocodes.dart';
import 'package:alerta_dengue/views/resultados.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String disease = 'dengue';
  String geocode = '2800308';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Alerta Dengue'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: disease,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              underline: Container(
                height: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  disease = value!;
                });
              },
              items: diseases.entries.map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
            ),
                        DropdownButton<String>(
              value: geocode,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              underline: Container(
                height: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  geocode = value!;
                });
              },
              items: geocodes.entries.map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Resultados()));
                },
                child: const Text('ir')),
          ],
        ),
      ),
    );
  }
}

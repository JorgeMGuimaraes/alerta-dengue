import 'package:flutter/material.dart';
import 'package:alerta_dengue/models/dados_request.dart';

class Resultados extends StatefulWidget {
  const Resultados({super.key, required this.dadosRequest});

  final DadosRequest dadosRequest;

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  @override
  void initState() {
    super.initState();
    testRequest();

  }
  
  void testRequest() {
    print('resultados');
    print(widget.dadosRequest.disease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Resultados'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('voltar'),
        ),
      ),
    );
  }
}
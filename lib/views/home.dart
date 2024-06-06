import 'package:alerta_dengue/models/diseases.dart';
import 'package:alerta_dengue/models/geocodes.dart';
import 'package:alerta_dengue/models/dados_request.dart';
import 'package:alerta_dengue/views/resultados.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
  String disease = 'dengue';
  String geocode = '2800308';
  String dataInicio = ''; //yyyy-mm-dd
  String dataFim = ''; //yyyy-mm-dd

class _HomeState extends State<Home> {
  String mensagem = '';

  bool isDataValida(String data) {
    List<String> partes = data.split('/');
    return data.length == 10 &&
    partes.length == 3 &&
    partes[0].length == 2 &&
    partes[1].length == 2 &&
    partes[2].length == 4;   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Alerta Dengue'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text('Selecione uma doença: '),
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
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('Selecione uma capital: '),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data de Início (dd/mm/aaaa)'),
                  onChanged: (value) {
                    setState(() {
                      if (isDataValida(value)) {
                        mensagem = '';
                        dataInicio = value;
                      } else {
                        mensagem = 'Favor corrigir data!';
                        dataInicio = '';
                      }
                       
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data de Fim (dd/mm/aaaa)'),
                  onChanged: (value) {
                      if (isDataValida(value)) {
                        mensagem = '';
                        dataFim = value;
                      } else {
                        mensagem = 'Favor corrigir data!';
                        dataFim = '';
                      }
                  },
                ),
              ),
              Text(
                mensagem,
                style: const TextStyle(color: Colors.red),
              ),
              ElevatedButton(
                  onPressed: () {
                    isBuscaValida()
                        ? setState(() {
                            mensagem = '';
                            DadosRequest dados = DadosRequest(
                                disease: disease,
                                geocode: geocode,
                                dataInicio: dataInicio,
                                dataFim: dataFim);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Resultados(
                                          dadosRequest: dados,
                                        )));
                          })
                        : setState(() {
                            mensagem = 'Preencha as datas corretamente';
                          });
                  },
                  child: const Text('ir')),
            ],
          ),
        ),
      ),
    );
  }

  bool isBuscaValida() {
    return isDataValida(dataInicio) && isDataValida(dataFim);
  }
}

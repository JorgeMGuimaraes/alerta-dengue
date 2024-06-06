import 'dart:convert';
import 'package:alerta_dengue/models/resultado.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  }

  Future<List<Resultado>> getResultados(DadosRequest dados) async {
    /// https://info.dengue.mat.br/api/alertcity?<PARAMETROS_DA_CONSULTA>
    /// ?geocode=3304557&disease=dengue&format=csv&ew_start=1&ew_end=50&ey_start=2017&ey_end=2017
    const String baseUrl = "https://info.dengue.mat.br/api/alertcity";
    //String url =
    //    "$baseUrl?geocode=${dados.geocode}&disease=${dados.disease}&format=json&ew_start=1&ew_end=50&ey_start=2017&ey_end=2017";

    String url =
        "https://info.dengue.mat.br/api/alertcity?geocode=3304557&disease=dengue&format=json&ew_start=1&ew_end=50&ey_start=2017&ey_end=2017";
    http.Response response = await http.get(Uri.parse(url));
    var jsonResultados = jsonDecode(response.body);
    List<Resultado> ret = [];

    for (var r in jsonResultados) {
      ret.add(Resultado.fromJson(r));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Resultados'),
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
              future: getResultados(widget.dadosRequest),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      print("Erro ao carregar: snapshot has error");
                      print(snapshot.error.toString());
                      print(snapshot.data.toString());

                      break;
                    } else {
                      List<Resultado>? resultados = snapshot.data;

                      return Expanded(
                          flex: 2,
                          child: ListView.builder(
                            itemCount: resultados!.length,
                            itemBuilder: (context, index) {
                              Resultado resultado = resultados[index];
                              return Card(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        const Text('Casos: '),
                                        Text(resultado.casos.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Text('Casos Estimados: '),
                                        Text(resultado.casosEst.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Text('Nível: '),
                                        Text(resultado.nivel.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Text('Temperatura Mínima: '),
                                        Text(resultado.tempmin.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Text('Temperatura Máxima: '),
                                        Text(resultado.tempmax.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ));
                    }
                }
                return const Text("Erro ao carregar builder");
              }),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('voltar'),
          )
        ],
      ),
    );
  }
}

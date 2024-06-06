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
    String url =
        "$baseUrl?geocode=${dados.geocode}&disease=${dados.disease}&format=json&ew_start=${dados.ewStart}&ew_end=${dados.ewEnd}&ey_start=${dados.eyStart}&ey_end=${dados.eyEnd}";

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
          Text(widget.dadosRequest.disease.toUpperCase()),
          Text(
              'Referente aos dias ${widget.dadosRequest.dataInicio} e ${widget.dadosRequest.dataFim}'),
          Text(
              'Entre a ${widget.dadosRequest.ewStart}.a semana de ${widget.dadosRequest.eyStart} e a ${widget.dadosRequest.ewEnd}.a semana de ${widget.dadosRequest.eyEnd}'),
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
                      debugPrint("Erro ao carregar: snapshot has error");
                      debugPrint(snapshot.error.toString());
                      debugPrint(snapshot.data.toString());

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
                                margin: const EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Text('Casos: '),
                                          Text(resultado.casos.toString()),
                                          const Text(' | Casos Estimados: '),
                                          Text(resultado.casosEst.toString()),
                                          Text(' | Nível: ${resultado.nivel.toString()}'),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                              'Temperatura Mínima: ${resultado.tempmin!.toStringAsFixed(2)}'),
                                          Text(
                                              ' | Temperatura Máxima: ${resultado.tempmax!.toStringAsFixed(2)}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ));
                    }
                }
                return const Text("Erro ao carregar builder");
              }),
        ],
      ),
    );
  }
}
